// view_all_page.dart
import 'package:flutter/material.dart';
import '../Models/product.dart';
import '../widgets/product_card.dart';

class ViewAllPage extends StatefulWidget {
  final List<Product> products;
  final String title;

  const ViewAllPage({super.key, required this.products, required this.title});

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  String? selectedCategory;
  String sortOption = 'Price: Low to High';

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = widget.products
        .where((product) => selectedCategory == null || product.category == selectedCategory)
        .toList();

    if (sortOption == 'Price: Low to High') {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Price: High to Low') {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text('Select Category'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All'),
                    ),
                    ...['Suitcases', 'Carry Bags', 'Sleep Pads'].map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: sortOption,
                  items: const [
                    DropdownMenuItem(
                      value: 'Price: Low to High',
                      child: Text('Price: Low to High'),
                    ),
                    DropdownMenuItem(
                      value: 'Price: High to Low',
                      child: Text('Price: High to Low'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      sortOption = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
