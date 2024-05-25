import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelgear/providers/vendor_product_provider.dart';
import '../Models/Product.dart';

class VendorProductDetailPage extends StatefulWidget {
  final String? productId;

  const VendorProductDetailPage({Key? key, this.productId}) : super(key: key);

  @override
  _VendorProductDetailPageState createState() => _VendorProductDetailPageState();
}

class _VendorProductDetailPageState extends State<VendorProductDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _category;
  late double _price;
  late int _quantity;
  late String _description;
  File? _imageFile;
  late bool _isDiscounted;
  late double _discountPercentage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      final product = Provider.of<VendorProductProvider>(context, listen: false)
          .getProductById(widget.productId!);
      if (product != null) {
        _name = product.name;
        _category = product.category;
        _price = product.price;
        _quantity = product.quantity;
        _description = product.description;
        _isDiscounted = product.isDiscounted;
        _discountPercentage = product.discountPercentage;
      }
    } else {
      _name = '';
      _category = 'Suitcases';
      _price = 0.0;
      _quantity = 0;
      _description = '';
      _isDiscounted = false;
      _discountPercentage = 0.0;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage() async {
    if (_imageFile == null) return '';
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await storageRef.putFile(_imageFile!);
    return await storageRef.getDownloadURL();
  }

  Future<void> _saveProduct() async {
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
          vendorProductProvider.updateProduct(widget.productId!, {
            'name': _name,
            'category': _category,
            'price': _price,
            'quantity': _quantity,
            'description': _description,
            'imageURL': imageUrl,
            'isDiscounted': _isDiscounted,
            'discountPercentage': _discountPercentage,
          });
        } else {
          final newProduct = Product(
            id: '',
            name: _name,
            category: _category,
            avgRating: 0.0,
            ratings: {},
            isTopRated: false,
            comments: {},
            vendor: 'vendorID',
            imageURL: imageUrl ?? '',
            price: _price,
            quantity: _quantity,
            isDiscounted: _isDiscounted,
            discountPercentage: _discountPercentage,
            discountedPrice: _price - (_price * _discountPercentage / 100),
            description: _description,
          );
          await vendorProductProvider.addProduct(newProduct);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId != null ? 'Edit Product' : 'Add Product'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: const InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
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
                    TextFormField(
                      initialValue: _price.toString(),
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product price';
                        }
                        if (double.tryParse(value) == null || double.parse(value) < 0) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _price = double.parse(value!);
                      },
                    ),
                    TextFormField(
                      initialValue: _quantity.toString(),
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product quantity';
                        }
                        if (int.tryParse(value) == null || int.parse(value) < 0) {
                          return 'Please enter a valid quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      initialValue: _description,
                      decoration: const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      onSaved: (value) {
                        _description = value!;
                      },
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
                      TextFormField(
                        initialValue: _discountPercentage.toString(),
                        decoration:
                            const InputDecoration(labelText: 'Discount Percentage'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter discount percentage';
                          }
                          if (double.tryParse(value) == null ||
                              double.parse(value) < 0 ||
                              double.parse(value) > 100) {
                            return 'Please enter a valid percentage (0-100)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _discountPercentage = double.parse(value!);
                        },
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
                      onPressed: () {
                        _saveProduct();
                      },
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
