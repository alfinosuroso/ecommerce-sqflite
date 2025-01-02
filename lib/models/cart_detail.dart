import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/user.dart';

class CartDetail {
  final Cart cart;
  final Product product;
  final User user;

  CartDetail({required this.cart, required this.product, required this.user});

  factory CartDetail.fromQueryRow(Map<String, dynamic> row) {
    return CartDetail(
      cart: Cart.fromQueryRow(row),
      product: Product.fromQueryRow(row),
      user: User.fromQueryRow(row),
    );
  }

  CartDetail.empty()
      : cart = Cart.empty(),
        product = Product.empty(),
        user = const User.empty();
}
