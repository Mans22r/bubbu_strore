// lib/views/profile_screen.dart

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/bottom_navbar.dart';
import 'home_screen.dart';
import 'wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final List<Product> _wishlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(wishlist: _wishlist)));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
    );
  }
}
