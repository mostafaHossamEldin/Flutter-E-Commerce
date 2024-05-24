// /// do code for providers
// /// get all products
// /// filter products based on category
// /// show discounted products
// ///
// /// add product to cart
// ///
// /// view single product
// ///
// /// rate a product
// /// add comment to the product with push notifcations
// ///
// /// add product with push notification
// ///
// /// update a product by adding a discount with push notifcation
// ///
// /// note all products have images
// /// I am suing fire base
// /// only vendors can add products and update them
// ///
// ///
// ///
// ///
// library;
// // providers.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Product.dart';


class ProductsProvider extends ChangeNotifier {
List<Product> _products = [];
List<Product> get products => _products;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference productsRef =FirebaseFirestore.instance.collection('products');

  Future<void> fetchProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      _products = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      // Handle errors
      print(e);
    }
  }

//Method to view a single product
  Future<Product> viewProduct(String productId) async {
    try {
      DocumentSnapshot doc = await productsRef.doc(productId).get();
      if (doc.exists) {
        return Product(
            id: doc.id,
            name: doc['name'],
            category: doc['category'],
            avgRating: doc['avgRating'].toDouble(),
            comments: List<String>.from(doc['comments']),
            vendor: doc['vendor'],
            imageURL: doc['imageURL'],
            price: doc['price'].toDouble(),
            isDiscounted: doc['discounted'],
            discountPercentage: doc['discountPercentage'].toDouble(),
            discountedPrice: doc['discountedPrice'].toDouble(),
            quantity: doc['quantity']);
      } else {
        throw Exception('Product not found');
      }
    } catch (error) {
      print('Failed to fetch product details: $error');
      // Handle error appropriately, e.g., log or show error message
      rethrow;
    }
  }

// Method to show all the comments of a product
  Future<List<String>> getProductComments(String productId) async {
    try {
      // Get the reference to the product document
      DocumentReference productRef =
          _firestore.collection('products').doc(productId);

      // Retrieve the product document
      DocumentSnapshot productSnapshot = await productRef.get();

      // Extract the comments array from the product document
      List<dynamic> commentsArray = productSnapshot['comments'];

      // Convert the comments array to a list of strings
      List<String> commentsList = commentsArray.cast<String>();

      return commentsList;
    } catch (error) {
      print('Error retrieving comments: $error');
      return []; // Return an empty list in case of error
    }
  }

//______________________________Placeholders for push notifications______________________________
// Placeholder function to send push notifications
  Future<void> sendPushNotificationToVendor(
      String vendorId, String title, String body) async {
    // Implement your push notification logic here
  }
  Future<void> sendPushNotificationToUsers(String title, String body) async {
// Implement your push notification logic here
  }
//______________________________________________________________________________________________
//----------------------here user has to be authenticated and a shopper
  // Method to rate a product
  Future<void> rateProduct(String productId, double rating) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's document reference
      DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      // Get the current user data
      DocumentSnapshot userSnapshot = await userRef.get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      if (userData['isVendor']) {
        print('Only shoppers can rate products.');
        return;
      }
      final productIndex = _products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        final product = _products[productIndex];
        product.ratings.add(rating);
        product.updateAvgRating();

        // Update Firebase
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
          'ratings': product.ratings,
          'avgRating': product.avgRating,
        });

        notifyListeners();
      }
    }else {
          // User not authenticated
          print('User not authenticated.');
        }
  }
    // Method to add comment to the product with push notifications
Future<void> addCommentWithNotification(
      String productId, String comment, String userId) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the user's document reference
        DocumentReference userRef =
            _firestore.collection('users').doc(user.uid);

        // Get the current user data
        DocumentSnapshot userSnapshot = await userRef.get();
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData['isVendor']) {
          print('Only shoppers can rate products.');
          return;
        }
      final productIndex = _products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        final product = _products[productIndex];
        product.comments.add(comment);

        // Update Firebase
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
          'comments': product.comments,
        });

        // Send push notification (assuming you have a function to do this)
        await sendPushNotificationToVendor(
            product.vendor, 'New comment on your product', comment);

        notifyListeners();
      }
      } else {
          // User not authenticated
          print('User not authenticated.');
        }
    }
// 
Future<void> addToCart(Product product) async {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Get the user's document reference
          DocumentReference userRef =
              _firestore.collection('users').doc(user.uid);

          // Get the current user data
          DocumentSnapshot userSnapshot = await userRef.get();
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          if (userData['isVendor']) {
                print('Only shoppers can rate products.');
          return;
        }

          // Get the current cart data
          Map<String, dynamic> cartData = userData['cart'] ?? {};

          // Check if the product is already in the cart
          if (cartData.containsKey(product.id)) {
            // Product already in cart, update quantity
            int currentQuantity = cartData[product.id] as int;
            cartData[product.id] = currentQuantity + 1;
          } else {
            // Product not in cart, add it with quantity 1
            cartData[product.id] = 1;
          }

          // Update the cart data in Firestore
          await userRef.update({'cart': cartData});

          // Notify listeners
          notifyListeners();
        } else {
          // User not authenticated
          print('User not authenticated.');
        }
      } catch (error) {
        print('Error adding to cart: $error');
      }
    }


    // Method to remove a product from the cart

    Future<void> removeFromCart(Product product) async {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Get the user's document reference
          DocumentReference userRef =
              _firestore.collection('users').doc(user.uid);

          // Get the current user data
          DocumentSnapshot userSnapshot = await userRef.get();
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
                 if (userData['isVendor']) {
          print('Only shoppers can rate products.');
          return;
        }

          // Get the current cart data
          Map<String, dynamic> cartData = userData['cart'] ?? {};

          // Check if the product is in the cart
          if (cartData.containsKey(product.id)) {
            // Product in cart, remove it
            cartData.remove(product.id);

            // Update the cart data in Firestore
            await userRef.update({'cart': cartData});

            // Notify listeners
            notifyListeners();
          }
        } else {
          // User not authenticated
          print('User not authenticated.');
        }
      } catch (error) {
        print('Error removing from cart: $error');
      }
    }

    // Method to clear the cart
    Future<void> clearCart() async {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Get the user's document reference
          DocumentReference userRef = _firestore.collection('users').doc(user.uid);
 DocumentSnapshot userSnapshot = await userRef.get();
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData['isVendor']) {
          print('Only shoppers can rate products.');
          return;
        }
          // Clear the cart data in Firestore
          await userRef.update({'cart': {}});
          notifyListeners();
        } else {
          // User not authenticated
          print('User not authenticated.');
        }
      } catch (error) {
        print('Error clearing cart: $error');
      }
    }
    // Method to view cart
    Future<Map<Product, int>> viewCart() async {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Get the user's document reference
          DocumentReference userRef =
              _firestore.collection('users').doc(user.uid);
 DocumentSnapshot userSnapshot = await userRef.get();
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData['isVendor']) {
          print('Only shoppers can rate products.');
          //return {}; 
          throw Exception('Only shoppers can rate products.');
        }else{
          // Get the current user data
          DocumentSnapshot userSnapshot = await userRef.get();
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          if (userData['isVendor']) {
          print('Only shoppers can rate products.');
          return {};
        }

          // Get the current cart data
          Map<String, dynamic> cartData = userData['cart'] ?? {};

          // Get the products in the cart
          Map<Product, int> cart = {};
          for (String productId in cartData.keys) {
            // Get the product details
            DocumentSnapshot productSnapshot =
                await productsRef.doc(productId).get();
            Map<String, dynamic> productData =
                productSnapshot.data() as Map<String, dynamic>;

            // Create a Product object
            Product product = Product(
              id: productId,
              name: productData['name'],
              category: productData['category'],
              avgRating: productData['avgRating'].toDouble(),
              comments: List<String>.from(productData['comments']),
              vendor: productData['vendor'],
              imageURL: productData['imageURL'],
              price: productData['price'].toDouble(),
              isDiscounted: productData['discounted'],
              discountPercentage: productData['discountPercentage'].toDouble(),
              discountedPrice: productData['discountedPrice'].toDouble(),
              quantity: productData['quantity'],
            );

            // Add the product to the cart
            cart[product] = cartData[productId] as int;
          }

          return cart;
        }
        } else {
          // User not authenticated
          print('User not authenticated.');
          return {};
        }
      } catch (error) {
        print('Error viewing cart: $error');
        return {};
      }
    }


 
//----------------------here user has to be authenticated and a vendor
    // Method to add product with push notification
    Future<void> addProductWithNotification(Product product) async {
      
      // Add product to Firebase Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .set({
        'name': product.name,
        'category': product.category,
        'avgRating': product.avgRating,
        'ratings': product.ratings,
        'comments': product.comments,
        'vendor': product.vendor,
        'imageURL': product.imageURL,
        'price': product.price,
        'discounted': product.isDiscounted,
        'discountPercentage': product.discountPercentage,
        'discountedPrice': product.discountedPrice,
      });

      // Send push notification to users about the new product
      await sendPushNotificationToUsers(
          'New product added', 'Check out the new product: ${product.name}');

      notifyListeners();
    }

    // Method to update a product by adding a discount with push notification
    Future<void> updateProductWithDiscount(
        String productId, double discountAmount, String vendorId) async {
      final productIndex = _products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        final product = _products[productIndex];
        product.discountPercentage = discountAmount;
        product.discountedPrice = product.price * (1 - discountAmount / 100);
        product.isDiscounted = true;

        // Update Firebase
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
          'discountPercentage': product.discountPercentage,
          'discountedPrice': product.discountedPrice,
          'discounted': product.isDiscounted = true,

        });

        // Send push notification to users about the discount
        await sendPushNotificationToUsers('Discount on ${product.name}',
            'Get $discountAmount% off on ${product.name}!');

        notifyListeners();
      }
    }
  }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../Models/Product.dart';
// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [];

//   List<Product> get products => _products;

//   Future<void> fetchProducts() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance.collection('products').get();
//       _products = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
//       notifyListeners();
//     } catch (e) {
//       // Handle errors
//       print(e);
//     }
//   }
// }