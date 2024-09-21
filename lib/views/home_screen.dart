// lib/views/home_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
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

  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = _productController.getProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filterProducts();
    });
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    }
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context); // Access wishlist provider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Products',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold), // Set title color to white
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistScreen(wishlist: []),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set background color to white
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none, // Remove default border
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load products'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            if (_allProducts.isEmpty) {
              _allProducts = snapshot.data!;
              _filteredProducts = List.from(_allProducts);
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: _filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  final isInWishlist = wishlistProvider.isInWishlist(product); // Get the wishlist status

                  return ProductCard(
                    product: product,
                    isInWishlist: isInWishlist,
                    onAddToWishlist: () {
                      if (isInWishlist) {
                        wishlistProvider.removeFromWishlist(product); // Remove from wishlist
                      } else {
                        wishlistProvider.addToWishlist(product); // Add to wishlist
                      }
                      setState(() {}); // Update the UI after adding/removing
                    },
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
            // Stay on HomeScreen
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
