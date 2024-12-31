import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:flutter/material.dart';

class ProductUtils {
  final BuildContext context;

  ProductUtils(this.context);

  List<ProductDetail> searchProducts({
    required String query,
    required List<ProductDetail> newProducts,
    required List<ProductDetail> oldProducts,
  }) {
    newProducts = oldProducts
        .where((item) =>
            item.product.name.toLowerCase().contains(query.toLowerCase()) ||
            item.product.description
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    return newProducts;
  }

  List<ProductDetail> filterProducts(
      {required String query,
      required List<ProductDetail> newProducts,
      required List<ProductDetail> oldProducts}) {
    switch (query) {
      case 'A-Z':
        newProducts = oldProducts;
        break;
      case 'Z-A':
        newProducts = oldProducts.reversed.toList();
        break;
      case "High-Low":
        newProducts = oldProducts
          ..sort((a, b) => b.product.price.compareTo(a.product.price));
        break;
      case "Low-High":
        newProducts = oldProducts
          ..sort((a, b) => a.product.price.compareTo(b.product.price));
        break;
    }
    return newProducts;
  }
}
