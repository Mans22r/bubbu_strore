// lib/controllers/product_controller.dart
import '../models/product_model.dart';

class ProductController {
  List<Product> getProducts() {
    return [
      Product(name: 'Product 1', imageUrl: 'assets/images/product1.png'),
      Product(name: 'Product 2', imageUrl: 'assets/images/product2.png'),
      Product(name: 'Product 3', imageUrl: 'assets/images/product3.png'),
      Product(name: 'Product 4', imageUrl: 'assets/images/product4.png'),
    ];
  }
}
