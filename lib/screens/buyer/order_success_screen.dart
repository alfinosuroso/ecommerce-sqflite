import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: Dimen.defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 45.w,
                backgroundImage: AssetImage('assets/images/order-success.jpg'),
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
                  context.go("/product-buyer");
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
