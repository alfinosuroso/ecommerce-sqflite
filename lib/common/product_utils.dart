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

  List<ProductDetail> filterProducts({
    required String query,
    required List<ProductDetail> products,
  }) {
    List<ProductDetail> newProducts;
    switch (query) {
      case 'A-Z':
        newProducts = products
          ..sort((a, b) => a.product.name.compareTo(b.product.name));
        break;
      case 'Z-A':
        newProducts = products
          ..sort((a, b) => b.product.name.compareTo(a.product.name));
        break;
      case "High-Low":
        newProducts = products
          ..sort((a, b) => b.product.price.compareTo(a.product.price));
        break;
      case "Low-High":
        newProducts = products
          ..sort((a, b) => a.product.price.compareTo(b.product.price));
        break;
      default:
        // sort by id
        newProducts = products
          ..sort((a, b) => a.product.id!.compareTo(b.product.id!));
        break;
    }
    return newProducts;
  }
}
