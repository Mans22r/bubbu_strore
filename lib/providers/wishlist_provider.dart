import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WishlistProvider with ChangeNotifier {
  List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  WishlistProvider() {
    _loadWishlist();  // Load wishlist from SharedPreferences
  }

  void addToWishlist(Product product) {
    if (!_wishlist.contains(product)) {
      _wishlist.add(product);
      _saveWishlist();  // Save wishlist to SharedPreferences
      notifyListeners(); // Notify listeners of changes
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.remove(product); // Remove product from the wishlist
    _saveWishlist(); // Save updated wishlist to SharedPreferences
    notifyListeners(); // Notify listeners of changes
  }

  bool isInWishlist(Product product) {
    return _wishlist.contains(product);
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? wishlistString = prefs.getString('wishlist');
    if (wishlistString != null) {
      List<dynamic> wishlistJson = json.decode(wishlistString);
      _wishlist = wishlistJson.map((data) => Product.fromJson(data)).toList();
      notifyListeners(); // Notify listeners when data is loaded
    }
  }

  Future<void> _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlistJson = _wishlist.map((product) => json.encode(product.toJson())).toList();
    prefs.setString('wishlist', json.encode(wishlistJson));
  }
}
