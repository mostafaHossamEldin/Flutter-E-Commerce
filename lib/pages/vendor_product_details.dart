import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelgear/providers/vendor_product_provider.dart';
import '../providers/userProvider.dart';
import '../Models/Product.dart';
import '../widgets/customTextFields.dart';

class VendorProductDetailPage extends StatefulWidget {
  final String? productId;

  VendorProductDetailPage({this.productId});

  @override
  _VendorProductDetailPageState createState() =>
      _VendorProductDetailPageState();
}

class _VendorProductDetailPageState extends State<VendorProductDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _category = 'Suitcases';
  double _price = 0.0;
  int _quantity = 0;
  String _description = '';
  File? _imageFile;
  bool _isDiscounted = false;
  double _discountPercentage = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorProductProvider>(context, listen: false)
          .fetchAndSetProducts();
      if (widget.productId != null) {
        final product =
            Provider.of<VendorProductProvider>(context, listen: false)
                .getProductById(widget.productId!);
        print("widget.productId " + widget.productId.toString());
        print("widget.productId " + product.toString());
        if (product != null) {
          setState(() {
            _name = product.name;
            _category = product.category;
            _price = product.price;
            _quantity = product.quantity;
            _description = product.description;
            _isDiscounted = product.isDiscounted;
            _discountPercentage = product.discountPercentage;
          });
        }
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      _showErrorDialog('No image selected.');
    }
  }

  Future<String> _uploadImage() async {
    if (_imageFile == null) return '';
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_imageFile!);
      return await storageRef.getDownloadURL();
    } catch (error) {
      _showErrorDialog('An error occurred while uploading the image.');
      rethrow;
    }
  }

  Future<void> _saveProduct() async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        String? imageUrl;
        if (_imageFile != null) {
          imageUrl = await _uploadImage();
        }
        final vendorProductProvider =
            Provider.of<VendorProductProvider>(context, listen: false);
        if (widget.productId != null) {
          await vendorProductProvider.updateProduct(widget.productId!, {
            'name': _name,
            'category': _category,
            'price': _price,
            'quantity': _quantity,
            'description': _description,
            'imageURL': imageUrl,
            'isDiscounted': _isDiscounted,
            'discountPercentage': _discountPercentage,
          });
          _showSnackBar('Product updated successfully');
        } else {
          print("UID: ${userProvider.user.uid}");
          final newProduct = Product(
            id: '',
            name: _name,
            category: _category,
            avgRating: 0.0,
            ratings: {},
            isTopRated: false,
            comments: {},
            vendor: userProvider.user.uid,
            imageURL: imageUrl ?? '',
            price: _price,
            quantity: _quantity,
            isDiscounted: _isDiscounted,
            discountPercentage: _discountPercentage,
            discountedPrice: _price - (_price * _discountPercentage / 100),
            description: _description,
          );
          await vendorProductProvider.addProduct(newProduct);
          _showSnackBar('Product added successfully');
        }
        context.go('/');
      } catch (error) {
        _showErrorDialog('An error occurred while saving the product.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("objecttttt" + _name);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId != null ? 'Edit Product' : 'Add Product'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    EditableTextField(
                      fieldName: 'Product Name',
                      hintText: _name,
                      isValid: (value) {
                        if (value == null || value.isEmpty) {
                          return false;
                        }
                        return true;
                      },
                      submitEdit: (value) {
                        _name = value.toString();
                      },
                      initialText: _name,

                      // decoration:
                      //     const InputDecoration(labelText: 'Product Name'),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter product name';
                      //   }
                      //   return null;
                      // },
                      // onSaved: (value) {
                      //   _name = value!;
                      // },
                    ),
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: ['Suitcases', 'Sleep Pads', 'Carry Bags']
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _category = value!;
                        });
                      },
                      onSaved: (value) {
                        _category = value!;
                      },
                    ),
                    EditableTextField(
                      fieldName: 'Price',
                      hintText: _price.toString(),
                      isValid: (value) {
                        if (value == null || value.isEmpty) {
                          return false;
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return false;
                        }
                        return true;
                      },
                      submitEdit: (value) {
                        _price = double.parse(value.toString());
                      },
                      initialText: _price.toString(),
                      // initialValue: _price.toString(),
                      // decoration: const InputDecoration(labelText: 'Price'),
                      // keyboardType: TextInputType.number,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter product price';
                      //   }
                      //   if (double.tryParse(value) == null ||
                      //       double.parse(value) <= 0) {
                      //     return 'Please enter a valid price greater than 0';
                      //   }
                      //   return null;
                      // },
                      // onSaved: (value) {
                      //   _price = double.parse(value!);
                      // },
                    ),
                    EditableTextField(
                      fieldName: 'Quantity',
                      hintText: _quantity.toString(),
                      isValid: (value) {
                        if (value == null || value.isEmpty) {
                          return false;
                        }
                        if (int.tryParse(value) == null ||
                            int.parse(value) <= 0) {
                          return false;
                        }
                        return true;
                      },
                      submitEdit: (value) {
                        _quantity = int.parse(value.toString());
                      },
                      initialText: _quantity.toString(),
                      // initialValue: _quantity.toString(),
                      // decoration: const InputDecoration(labelText: 'Quantity'),
                      // keyboardType: TextInputType.number,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter product quantity';
                      //   }
                      //   if (int.tryParse(value) == null ||
                      //       int.parse(value) <= 0) {
                      //     return 'Please enter a valid quantity greater than 0';
                      //   }
                      //   return null;
                      // },
                      // onSaved: (value) {
                      //   _quantity = int.parse(value!);
                      // },
                    ),
                    EditableTextField(
                      fieldName: 'Description',
                      hintText: _description,
                      isValid: (value) {
                        if (value == null || value.isEmpty) {
                          return false;
                        }
                        return true;
                      },
                      submitEdit: (value) {
                        _description = value.toString();
                      },
                      initialText: _description,
                      // initialValue: _description,
                      // decoration:
                      //     const InputDecoration(labelText: 'Description'),
                      // maxLines: 3,
                      // onSaved: (value) {
                      //   _description = value!;
                      // },
                    ),
                    SwitchListTile(
                      title: const Text('Discounted'),
                      value: _isDiscounted,
                      onChanged: (value) {
                        setState(() {
                          _isDiscounted = value;
                        });
                      },
                    ),
                    if (_isDiscounted)
                      EditableTextField(
                        fieldName: 'Discount Percentage',
                        hintText: _discountPercentage.toString(),
                        isValid: (value) {
                          if (value == null || value.isEmpty) {
                            return false;
                          }
                          if (double.tryParse(value) == null ||
                              double.parse(value) < 0 ||
                              double.parse(value) > 100) {
                            return false;
                          }
                          return true;
                        },
                        submitEdit: (value) {
                          _discountPercentage = double.parse(value.toString());
                        },
                        initialText: _discountPercentage.toString(),
                        // initialValue: _discountPercentage.toString(),
                        // decoration: const InputDecoration(
                        //     labelText: 'Discount Percentage'),
                        // keyboardType: TextInputType.number,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter discount percentage';
                        //   }
                        //   if (double.tryParse(value) == null ||
                        //       double.parse(value) < 0 ||
                        //       double.parse(value) > 100) {
                        //     return 'Please enter a valid percentage (0-100)';
                        //   }
                        //   return null;
                        // },
                        // onSaved: (value) {
                        //   _discountPercentage = double.parse(value!);
                        // },
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _imageFile == null
                            ? const Text('No image selected.')
                            : Image.file(_imageFile!, height: 100, width: 100),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Select Image'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveProduct,
                      child: Text(widget.productId != null
                          ? 'Update Product'
                          : 'Add Product'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
