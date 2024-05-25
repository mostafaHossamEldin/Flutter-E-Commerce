// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../Models/Product.dart';
// class VendorProductProvider with ChangeNotifier{
// Future<void> sendPushNotificationToUsers(String title, String body) async {
// // Implement your push notification logic here
//   }

//      // Method to add product with push notification
//     Future<void> addProductWithNotification(Product product) async {
      
//       // Add product to Firebase Firestore
//       await FirebaseFirestore.instance
//           .collection('products')
//           .doc(product.id)
//           .set({
//         'name': product.name,
//         'category': product.category,
//         'avgRating': product.avgRating,
//         'ratings': product.ratings,
//         'comments': product.comments,
//         'vendor': product.vendor,
//         'imageURL': product.imageURL,
//         'price': product.price,
//         'discounted': product.isDiscounted,
//         'discountPercentage': product.discountPercentage,
//         'discountedPrice': product.discountedPrice,
//       });

//       // Send push notification to users about the new product
//       await sendPushNotificationToUsers(
//           'New product added', 'Check out the new product: ${product.name}');

//       notifyListeners();
//     }

//     // Method to update a product by adding a discount with push notification
//     Future<void> updateProductWithDiscount(
//         String productId, double discountAmount, String vendorId) async {
//       final productIndex = _products.indexWhere((p) => p.id == productId);
//       if (productIndex != -1) {
//         final product = _products[productIndex];
//         product.discountPercentage = discountAmount;
//         product.discountedPrice = product.price * (1 - discountAmount / 100);
//         product.isDiscounted = true;

//         // Update Firebase
//         await FirebaseFirestore.instance
//             .collection('products')
//             .doc(productId)
//             .update({
//           'discountPercentage': product.discountPercentage,
//           'discountedPrice': product.discountedPrice,
//           'discounted': product.isDiscounted = true,

//         });

//         // Send push notification to users about the discount
//         await sendPushNotificationToUsers('Discount on ${product.name}',
//             'Get $discountAmount% off on ${product.name}!');

//         notifyListeners();
//       }
//     }
//   }
  