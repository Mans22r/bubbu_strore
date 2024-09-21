// lib/views/wishlist_screen.dart

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/bottom_navbar.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class WishlistScreen extends StatelessWidget {
  final List<Product> wishlist;

  const WishlistScreen({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Wishlist'),
      ),
      body: wishlist.isEmpty
          ? const Center(child: Text('No items in your wishlist'))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
       bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(wishlist: wishlist)));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
    );
  }
}
