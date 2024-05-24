import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isTopRated;
  final bool isDiscounted;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isTopRated = false,
    this.isDiscounted = false,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    // Print the data for debugging purposes
    print(data);
    
    // Convert the data to the correct types, especially for double values
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] is int) ? (data['price'] as int).toDouble() : (data['price'] ?? 0.0),
      rating: (data['rating'] is int) ? (data['rating'] as int).toDouble() : (data['rating'] ?? 0.0),
      imageUrl: data['imageUrl'] ?? '',
      isTopRated: data['isTopRated'] ?? false,
      isDiscounted: data['isDiscounted'] ?? false,
    );
  }
}