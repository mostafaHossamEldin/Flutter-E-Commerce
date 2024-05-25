import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/Models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';


class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = productProvider.getProductById(productId);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageURL),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.category,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Available in stock', style: TextStyle(fontSize: 16)),
                Text('Rating: ${product.avgRating}'),
              ],
            ),
            const SizedBox(height: 16),
            // Row(
            //   children: [
            //     ...['S', 'M', 'L'].map((size) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //         child: ChoiceChip(
            //           label: Text(size),
            //           selected: product.size == size,
            //           onSelected: (selected) {
            //             productProvider.updateProductSize(productId, size);
            //           },
            //         ),
            //       );
            //     }).toList(),
            //   ],
            // ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cartProvider.addToCart(product as Product);
                    },
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
