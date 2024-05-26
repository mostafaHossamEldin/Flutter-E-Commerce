import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Address.dart';

class Userdb {
  String uid;
  String email;
  String displayName;
  bool isVendor; // Indicates whether the user is a vendor
  Map<String, int> cart; // Represents the user's cart (productId -> quantity)
  bool isLoggedIn;
  String companyName;
  String gender;
  List<Address> addresses;
  Image profilePicture;
  List<String> favorites;

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
