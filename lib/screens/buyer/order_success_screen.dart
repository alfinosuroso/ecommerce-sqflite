import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  final User? _user = AuthService.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Padding(
          padding: Dimen.defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 45.w,
                backgroundImage:
                    const AssetImage('assets/images/order-success.jpg'),
              ),
              Dimen.verticalSpaceMedium,
              Text(
                "Pembelian Berhasil!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppThemeData.getTheme(context).primaryColor),
              ),
              Dimen.verticalSpaceMedium,
              Text(
                "Pembayaran Anda berhasil! Produk anda sedang dalam perjalanan",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Dimen.verticalSpaceLarge,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue),
                onPressed: () {
                  context.go("/");
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppThemeData.getTheme(context).primaryColor),
                ),
              ),
              Dimen.verticalSpaceLarge,
              Dimen.verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
