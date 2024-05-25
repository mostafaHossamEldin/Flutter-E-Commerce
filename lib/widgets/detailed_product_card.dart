import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';

class DetailedProductCard extends StatelessWidget {
  final Product product;

  const DetailedProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/product/${product.id}');
      },
      child: Card(
        child: Column(
          children: [
            Image.network(product.imageURL),
            Text(product.name),
            Text('\$${product.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
