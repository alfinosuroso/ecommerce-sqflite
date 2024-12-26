import 'package:ecommerce_sqflite/screens/buyer/buyer_product_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String role = "buyer";
    if (role == "buyer") {
      return const BuyerProductListScreen();
    }
    return const Placeholder();
  }
}