// models/product_model.dart
class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int stock;
  final int sellerId; // Foreign key to the User (Seller)

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
    required this.sellerId,
  });

  // Convert from Map
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        stock: json['stock'],
        sellerId: json['sellerId'],
      );

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'stock': stock,
      'sellerId': sellerId
    };
  }
}
