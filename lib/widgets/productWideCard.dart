import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../Models/product.dart';

class ProductWideCard extends HookWidget {
  final Product product;
  final Function() deleteProduct;
  final Function() editProduct;
  final bool canSetQuantity;
  final bool isVendor;

  ProductWideCard({
    required this.product,
    required this.deleteProduct,
    required this.editProduct,
    required this.canSetQuantity,
    required this.isVendor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/product/${product.id}');
        },
        child: Container(
          child: Column(
            children: [
              Image.network(product.imageURL, fit: BoxFit.cover, height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.price.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isVendor
                    ? [
                        ElevatedButton(
                          onPressed: editProduct,
                          child: const Text("Edit"),
                        ),
                        ElevatedButton(
                          onPressed: deleteProduct,
                          child: const Text("Delete"),
                        ),
                      ]
                    : [
                        ElevatedButton(
                          onPressed: editProduct,
                          child: const Text("View"),
                        ),
                        ElevatedButton(
                          onPressed: deleteProduct,
                          child: const Text("Remove"),
                        ),
                      ],
              )
            ],
          ),
        ));
  }
}
