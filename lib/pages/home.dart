import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/Models/product.dart';
import 'package:travelgear/providers/product_provider.dart';
import 'package:travelgear/widgets/product_card.dart';
import 'package:travelgear/widgets/category_chip.dart';
import 'package:travelgear/Models/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  String searchTerm = '';

  final List<Category> categories = [
    Category(name: 'Suitcases'),
    Category(name: 'Carry Bags'),
    Category(name: 'Sleep Pads')
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final products = productProvider.products;
    final filteredProducts = products
        .where((product) =>
            (selectedCategory == null ||
                product.category == selectedCategory) &&
            product.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    final topRatedProducts =
        filteredProducts.where((product) => product.isTopRated).toList();
    final discountedProducts =
        filteredProducts.where((product) => product.isDiscounted).toList();
    final allProducts = filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore the Travel Gear'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore the Travel Gear',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoryChip(
                          label: 'All',
                          isSelected: selectedCategory == null,
                          onSelected: () {
                            setState(() {
                              selectedCategory = null;
                              searchTerm = '';
                            });
                          },
                        ),
                      );
                    } else {
                      final category = categories[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoryChip(
                          label: category.name,
                          isSelected: selectedCategory == category.name,
                          onSelected: () {
                            setState(() {
                              selectedCategory = category.name;
                              searchTerm = '';
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              buildSectionHeader(context, 'Top Rated', () {
                context.push('/view-all', extra: {
                  'products': topRatedProducts,
                  'title': 'Top Rated'
                });
              }),
              buildHorizontalProductList(context, topRatedProducts),
              const SizedBox(height: 16),
              buildSectionHeader(context, 'Discounts', () {
                context.push('/view-all', extra: {
                  'products': discountedProducts,
                  'title': 'Discounts'
                });
              }),
              buildHorizontalProductList(context, discountedProducts),
              const SizedBox(height: 16),
              buildSectionHeader(context, 'All Products', () {
                context.push('/view-all',
                    extra: {'products': allProducts, 'title': 'All Products'});
              }),
              buildHorizontalProductList(context, allProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(
      BuildContext context, String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text('View All'),
        ),
      ],
    );
  }

  Widget buildHorizontalProductList(
      BuildContext context, List<Product> products) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length > 5 ? 6 : products.length,
        itemBuilder: (context, index) {
          if (index == 5) {
            return TextButton(
              onPressed: () {
                context.push('/view-all',
                    extra: {'products': products, 'title': 'All Products'});
              },
              child: const Text('View All'),
            );
          } else {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                context.push('/product/${product.id}');
              },
              child: Container(
                width: 160,
                margin: const EdgeInsets.only(right: 8.0),
                child: ProductCard(product: product),
              ),
            );
          }
        },
      ),
    );
  }

}
