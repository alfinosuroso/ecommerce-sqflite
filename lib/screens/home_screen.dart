import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/screens/buyer/buyer_product_list_screen.dart';
import 'package:ecommerce_sqflite/screens/seller/seller_product_list_screen.dart';
import 'package:ecommerce_sqflite/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("sebelum bloc");
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserByIdLoaded) {
          SharedCode(context)
              .successSnackBar(text: "Welcome, ${state.user.username}!");
        }
      },
      builder: (context, state) {
        debugPrint("bloc builder");
        if (state is UserByIdLoaded) {
          if (state.user.role == "Pembeli") {
            return const BuyerProductListScreen();
          }
          if (state.user.role == "Penjual") {
            return const SellerProductListScreen();
          }
        }
        return const SignInScreen();
      },
    );
  }
}
