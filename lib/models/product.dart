// models/product_model.dart
class Product {
  final int? id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int stock;
  final int userId; // Foreign key to the User (Seller)

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
    required this.userId,
  });

  // Convert from Map
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        stock: json['stock'],
        userId: json['userId'],
      );

  // Convert from Query Row (with aliases)
  factory Product.fromQueryRow(Map<String, dynamic> row) => Product(
        id: row['product_id'] as int?,
        name: row['product_name'] as String,
        description: row['product_description'] as String,
        image: row['product_image'] as String,
        price: (row['product_price'] as num).toDouble(),
        stock: row['product_stock'] as int,
        userId: row['user_id'] as int,
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
      'userId': userId
    };
  }

  Product.empty()
      : this(
            id: null,
            name: '',
            description: '',
            image: '',
            price: 0.0,
            stock: 0,
            userId: 0);
}
