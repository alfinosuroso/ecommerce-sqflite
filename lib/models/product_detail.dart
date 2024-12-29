import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/user.dart';

class ProductDetail {
  final Product product;
  final User user;

  ProductDetail({required this.product, required this.user});

  factory ProductDetail.fromQueryRow(Map<String, dynamic> row) => ProductDetail(
        product: Product.fromQueryRow(row),
        user: User.fromQueryRow(row),
      );

  ProductDetail.empty()
      : product = Product.empty(),
        user = const User.empty();
}
