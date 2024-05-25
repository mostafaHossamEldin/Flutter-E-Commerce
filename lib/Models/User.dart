import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Address.dart';

class Userdb {
  final String uid;
  final String email;
  final String displayName;
  final bool isVendor; // Indicates whether the user is a vendor
  final Map<String, int>
      cart; // Represents the user's cart (productId -> quantity)
  final isLoggedIn;
  final String companyName;
  final int gender;
  final List<Address> addresses;
  final Image profilePicture;
  final List<String> favorites;

  Userdb({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.isVendor,
    required this.cart, // Initialize the cart
    required this.isLoggedIn,
    required this.companyName,
    required this.gender,
    required this.addresses,
    required this.profilePicture,
    required this.favorites,
  });
}
