// lib/views/wishlist_screen.dart

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/wishlist_provider.dart';
import 'expanded_product_page.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key, required List wishlist});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlist = wishlistProvider.wishlist;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Favorites',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold), // Set title color to white
        ),
        centerTitle: true,
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text('No items in your favorite list'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedProductPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          // Image on the left side of the card
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              product.imageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Product info (name, price, description) on the right
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 2),
                                Text(
                                  product.description.length > 50
                                      ? '${product.description.substring(0, 50)}...'
                                      : product.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      );
  }
}
