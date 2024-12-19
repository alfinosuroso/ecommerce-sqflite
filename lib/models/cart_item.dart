// models/cart_item_model.dart
class CartItem {
  final int id;
  final int userId; // Foreign key to the User (Buyer)
  final int productId; // Foreign key to the Product
  final int quantity;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
