import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ExpandedProductPage extends StatelessWidget {
  final Product product;

  const ExpandedProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(product.name),
      ),
      body: SingleChildScrollView( // Wrap the body in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image section
            ProductImage(imageUrl: product.imageUrl),
            const SizedBox(height: 20),
            // Product name
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 30),
            // Product price
            Text(
              '₹${product.price.toStringAsFixed(2)}/-',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            const Divider(color: Colors.black,),
            const SizedBox(height: 10),
            // Detailed description
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black,),
            const SizedBox(height: 5),
            // Additional content: home delivery and return policy
            const Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.green),
                SizedBox(width: 10),
                Text('Free Home Delivery'),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('30 Days Return Policy'),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.currency_rupee, color: Colors.green),
                SizedBox(width: 10),
                Text('Cash on Delivery'),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.green),
                SizedBox(width: 10),
                Text('Top Brand'),
              ],
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Padding around the outer card
      child: Card(
        elevation: 4.0,
        color: Colors.white, // Elevation for the outer card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Outer card border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0), // Padding between the two cards
          child: Card(
            elevation: 0.0, // Elevation for the inner card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Inner card border radius
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 250, // Fixed height for the image
                width: double.infinity, // Stretch to full width
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.broken_image, size: 100));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
