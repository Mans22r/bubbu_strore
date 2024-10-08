// lib/widgets/productCard.dart

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isInWishlist;
  final VoidCallback onAddToWishlist;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.onAddToWishlist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Container(
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image, size: 50));
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _trimProductName(product.name),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price.toStringAsFixed(2)}/-',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        product.description.length > 40
                            ? '${product.description.substring(0, 40)}...'
                            : product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.red : const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: onAddToWishlist,
              ),
            ),
          ],
        ),
      ),
    );
  }


  String _trimProductName(String name) {
    List<String> words = name.split(' ');
    if (words.length > 3) {
      return '${words.take(3).join(' ')}...';
    }
    return name;
  }
}
