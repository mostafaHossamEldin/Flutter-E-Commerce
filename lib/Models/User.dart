import 'package:flutter/material.dart';

class User {
  final String uid;
  final String email;
  final String displayName;
  final bool isVendor; // Indicates whether the user is a vendor
  final Map<String, int>
      cart; // Represents the user's cart (productId -> quantity)

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.isVendor,
    required this.cart, // Initialize the cart
  });
}
