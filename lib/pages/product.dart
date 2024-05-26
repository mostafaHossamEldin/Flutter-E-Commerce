import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelgear/providers/userProvider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final product = productProvider.getProductById(widget.productId);
    final user = FirebaseAuth.instance.currentUser;
    // if the user is not logged in, the userRating will be 0, else it will be the rating of the user if he has rated the product before
    double userRating = user != null ? product?.ratings[user.uid] ?? 0 : 0;
    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.imageURL,
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.category,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: userRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {
                          if (user != null) {
                            await productProvider.addRating(
                                widget.productId, user.uid, rating);
                            setState(() {
                              userRating = rating;
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Required'),
                                content: const Text(
                                    'Please log in to rate this product.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        GoRouter.of(context).go('/login'),
                                    child: const Text('Login'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        //  '${product.avgRating.toStringAsFixed(1)} Rating (${product.comments.length} Reviews)',
                        '${product.avgRating.toStringAsFixed(1)} Rating (${product.ratings.length} Reviews)',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                'Available in stock',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (product.isDiscounted)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Was: \$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          'New: \$${(product.price - (product.price * product.discountPercentage / 100)).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Leave a comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSubmitted: (comment) async {
                  if (user != null) {
                    await productProvider.addComment(
                        widget.productId, user.email!, comment);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You have successfully added a comment.'),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Login Required'),
                        content:
                            const Text('Please log in to leave a comment.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                          TextButton(
                            onPressed: () => GoRouter.of(context).go('/login'),
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: product.comments.length,
                itemBuilder: (context, index) {
                  final commentKeys = product.comments.keys.toList();
                  final commentAuthor = commentKeys[index];
                  final commentText = product.comments[commentAuthor]!;
                  return ListTile(
                    title: Text(commentAuthor),
                    subtitle: Text(commentText),
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    userProvider.updateUserProfile("cart", {
                      ...userProvider.user.cart,
                      widget.productId: quantity
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                  ),
                  // child: Text(
                  //   '\$${(product.price * quantity).toStringAsFixed(2)} Add to cart',
                  //   style: const TextStyle(fontSize: 18),
                  // ),
                  // If the product is discounted, use the discounted price, else use the original price and beside it Add to cart
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Text(
                      product.isDiscounted
                          ? '\$${(product.discountedPrice * quantity).toStringAsFixed(2)} Add to cart'
                          : '\$${(product.price * quantity).toStringAsFixed(2)} Add to cart',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
