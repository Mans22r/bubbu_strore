// lib/controllers/product_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController {
  Future<List<Product>> getProducts() async {
    const String apiUrl = 'https://fakestoreapi.com/products';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> productData = json.decode(response.body);

      // Map the product data to the Product model using the factory method
      List<Product> products = productData.map((data) {
        return Product.fromJson(data);
      }).toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
