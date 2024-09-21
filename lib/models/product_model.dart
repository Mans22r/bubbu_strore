// product_model.dart
class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  // Factory method to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['title'],
      imageUrl: json['image'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'image': imageUrl,
      'price': price,
      'description': description,
    };
  }
}
