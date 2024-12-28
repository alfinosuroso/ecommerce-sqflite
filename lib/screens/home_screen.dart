import 'package:ecommerce_sqflite/screens/buyer/buyer_product_list_screen.dart';
import 'package:ecommerce_sqflite/screens/seller/seller_product_list_screen.dart';
import 'package:ecommerce_sqflite/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String role = "";
    if (role == "buyer") {
      return const BuyerProductListScreen();
    }
    if (role == "seller") {
      return const SellerProductListScreen();
    }
    return const SignInScreen();
  }
}
