// lib/views/expanded_product_page.dart
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ExpandedProductPage extends StatelessWidget {
  final Product product;

  const ExpandedProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 20),
            // Product name
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            // Product price
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Detailed description
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Additional content: home delivery and return policy
            const Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.green),
                SizedBox(width: 10),
                Text('Free Home Delivery'),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('30 Days Return Policy'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
