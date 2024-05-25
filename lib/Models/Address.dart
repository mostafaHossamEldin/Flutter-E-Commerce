import 'package:flutter/material.dart';

class Address {
  final String streetAddress1;
  final String StreetAddress2;
  final String country;
  final String state;
  final String city;
  final String phone;

  Address({
    required this.streetAddress1,
    required this.StreetAddress2,
    required this.country,
    required this.state,
    required this.city,
    required this.phone,
  });
}
