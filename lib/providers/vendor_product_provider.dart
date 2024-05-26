import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Product.dart';

class VendorProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  VendorProductProvider() {
    fetchAndSetProducts();
  }

  List<Product> get products => [..._products];

  Product? getProductById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    print('Fetching products from Firestore...');
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    print('Fetched ${snapshot.docs.length} documents.');

    _products.clear();
    for (var doc in snapshot.docs) {
      print('Document data: ${doc.data()}');
      _products.add(Product.fromFirestore(doc));
    }
    print('Products after fetching: $_products');
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final docRef = await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap());
    final newProduct = Product(
      id: docRef.id,
      name: product.name,
      category: product.category,
      avgRating: product.avgRating,
      ratings: product.ratings,
      isTopRated: product.isTopRated,
      comments: product.comments,
      vendor: product.vendor,
      imageURL: product.imageURL,
      price: product.price,
      quantity: product.quantity,
      isDiscounted: product.isDiscounted,
      discountPercentage: product.discountPercentage,
      discountedPrice: product.discountedPrice,
      description: product.description,
    );
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    print('I am INSIDE UPDATE');
    print(id);

    print('PRODUCTS');
    print(_products);

    final productIndex = _products.indexWhere((prod) => prod.id == id);

    print(productIndex);
    if (productIndex >= 0) {
      try {
        // Update Firestore document
        await FirebaseFirestore.instance
            .collection('products')
            .doc(id)
            .update(data);

        // Create updated product object
        final updatedProduct = Product(
          id: id,
          name: data['name'] ?? _products[productIndex].name,
          category: data['category'] ?? _products[productIndex].category,
          avgRating: _products[productIndex].avgRating,
          ratings: _products[productIndex].ratings,
          isTopRated: _products[productIndex].isTopRated,
          comments: _products[productIndex].comments,
          vendor: _products[productIndex].vendor,
          imageURL: data['imageURL'] ?? _products[productIndex].imageURL,
          price: data['price'] ?? _products[productIndex].price,
          quantity: data['quantity'] ?? _products[productIndex].quantity,
          isDiscounted:
              data['isDiscounted'] ?? _products[productIndex].isDiscounted,
          discountPercentage: data['discountPercentage'] ??
              _products[productIndex].discountPercentage,
          discountedPrice: data.containsKey('discountPercentage')
              ? (data['price'] ?? _products[productIndex].price) -
                  ((data['price'] ?? _products[productIndex].price) *
                      data['discountPercentage'] /
                      100)
              : _products[productIndex].discountedPrice,
          description:
              data['description'] ?? _products[productIndex].description,
        );

        // Update local list of products
        _products[productIndex] = updatedProduct;
        notifyListeners();
      } catch (error) {
        print('Failed to update product: $error');
        throw error; // rethrow the error after logging it
      }
    } else {
      print('Product not found for update');
    }
  }

  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
