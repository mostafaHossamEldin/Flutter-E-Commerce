import 'package:cloud_firestore/cloud_firestore.dart';
class Product {
  final String id;
  String name;
  String category;
  double avgRating;
  List<double> ratings;
  bool  isTopRated;
  List<String> comments;
  String vendor;
  String imageURL;
  double price;
  int quantity; // New field to represent the quantity of the product
  bool isDiscounted;
  double discountPercentage;
  double discountedPrice;

  Product({
    required this.id,
    required this.name,
    required this.category,
    this.avgRating = 0.0,
    this.ratings = const [],
    this.isTopRated = false,
    this.comments = const [],
    required this.vendor,
    required this.imageURL,
    required this.price,
    required this.quantity, // Initialize quantity
    required this.isDiscounted,
    required this.discountPercentage,
    required this.discountedPrice,
  });

  // Method to update the average rating
  void updateAvgRating() {
    if (ratings.isNotEmpty) {
      avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
    } else {
      avgRating = 0.0;
    }
  }

factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    // Print the data for debugging purposes
    print(data);

    List<double> parsedRatings = [];
    if (data['ratings'] != null) {
      for (var rating in data['ratings']) {
        if (rating is int) {
          parsedRatings.add(rating.toDouble());
        } else if (rating is double) {
          parsedRatings.add(rating);
        }
      }
    }

    return Product(
      id: doc.id, 
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      avgRating: (data['avgRating'] is int) ? (data['avgRating'] as int).toDouble() : (data['avgRating'] ?? 0.0),
      ratings: parsedRatings,
      isTopRated: data['isTopRated'] ?? false,
      comments: (data['comments'] ?? []).map<String>((comment) => comment.toString()).toList(),
      vendor: data['vendor'] ?? '',
      imageURL: data['imageURL'] ?? '',
      price: (data['price'] is int) ? (data['price'] as int).toDouble() : (data['price'] ?? 0.0),
      quantity: data['quantity'] ?? 0, // Initialize quantity
      isDiscounted: data['isDiscounted'] ?? false,
      discountPercentage: (data['discountPercentage'] is int) ? (data['discountPercentage'] as int).toDouble() : (data['discountPercentage'] ?? 0.0),
      discountedPrice: (data['discountedPrice'] is int) ? (data['discountedPrice'] as int).toDouble() : (data['discountedPrice'] ?? 0.0),
    );
  }

}

