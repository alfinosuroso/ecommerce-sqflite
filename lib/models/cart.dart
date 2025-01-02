// models/cart_item_model.dart
class Cart {
  final int? id;
  final int userId; // Foreign key to the User (Buyer)
  final int productId; // Foreign key to the Product
  final int quantity;

  Cart({
    this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        quantity: json['quantity'],
      );

  factory Cart.fromQueryRow(Map<String, dynamic> row) => Cart(
        id: row['cart_id'] as int?,
        userId: row['cart_user_id'] as int,
        productId: row['cart_product_id'] as int,
        quantity: row['cart_quantity'] as int,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  Cart.empty()
      : id = null,
        userId = 0,
        productId = 0,
        quantity = 0;
}
