import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Product.dart';

class VendorProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => [..._products];

  Product? getProductById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }


  Future<void> fetchAndSetProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    _products.clear();
    for (var doc in snapshot.docs) {
      _products.add(Product.fromFirestore(doc));
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final docRef = await FirebaseFirestore.instance.collection('products').add(product.toMap());
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
    final productIndex = _products.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      await FirebaseFirestore.instance.collection('products').doc(id).update(data);
      final updatedProduct = Product(
        id: id,
        name: data['name'],
        category: data['category'],
        avgRating: _products[productIndex].avgRating,
        ratings: _products[productIndex].ratings,
        isTopRated: _products[productIndex].isTopRated,
        comments: _products[productIndex].comments,
        vendor: _products[productIndex].vendor,
        imageURL: data['imageURL'] ?? _products[productIndex].imageURL,
        price: data['price'],
        quantity: data['quantity'],
        isDiscounted: data['isDiscounted'],
        discountPercentage: data['discountPercentage'],
        discountedPrice: data['price'] - (data['price'] * data['discountPercentage'] / 100),
        description: data['description'],
      );
      _products[productIndex] = updatedProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
