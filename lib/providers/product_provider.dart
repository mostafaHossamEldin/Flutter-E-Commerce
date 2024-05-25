import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    _products = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Product? getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> addRating(String productId, String userId, double rating) async {
    final product = getProductById(productId);
    if (product != null) {
      product.ratings[userId] = rating;
      product.updateAvgRating();
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'ratings': product.ratings,
        'avgRating': product.avgRating,
      });
      notifyListeners();
    }
  }

  Future<void> addComment(String productId, String userId, String comment) async {
    final product = getProductById(productId);
    if (product != null) {
      // Append new comment if user already commented
      product.comments.update(userId, (existingComment) => '$existingComment\n$comment', ifAbsent: () => comment);
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'comments': product.comments,
      });
      notifyListeners();
    }
  }

  
}
