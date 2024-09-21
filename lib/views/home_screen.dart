// lib/views/home_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/productCard.dart';
import 'wishlist_screen.dart';
import 'expanded_product_page.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _productController = ProductController();
  late Future<List<Product>> _productsFuture;
  final List<Product> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = _productController.getProducts();
  }

  void _addToWishlist(Product product) {
    setState(() {
      if (_wishlist.contains(product)) {
        _wishlist.remove(product);
      } else {
        _wishlist.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen(wishlist: _wishlist)),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load products'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Product> products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 0.60,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    isInWishlist: _wishlist.contains(product),
                    onAddToWishlist: () => _addToWishlist(product),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExpandedProductPage(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No products available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(wishlist: _wishlist)));
          }  else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
    );
  }
}
