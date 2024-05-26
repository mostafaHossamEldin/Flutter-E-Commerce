import 'package:flutter/material.dart';

class Address {
  final String streetAddress1;
  final String streetAddress2;
  final String country;
  final String state;
  final String city;
  final String phoneNumber;
  final String zipCode;

  Address({
    required this.streetAddress1,
    required this.streetAddress2,
    required this.country,
    required this.state,
    required this.city,
    required this.phoneNumber,
    required this.zipCode,
  });

  String toString() {
    return "{StreetAddress1: $streetAddress1, StreetAddress2: $streetAddress2, Country: $country, State: $state, City: $city, PhoneNumber: $phoneNumber, ZipCode: $zipCode}";
  }

  Map<String, dynamic> toJson() {
    return {
      'streetAddress1': streetAddress1,
      'streetAddress2': streetAddress2,
      'country': country,
      'state': state,
      'city': city,
      'phoneNumber': phoneNumber,
      'zipCode': zipCode,
    };
  }
}
