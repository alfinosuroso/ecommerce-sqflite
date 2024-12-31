import 'dart:io';

import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class BuyerProductDetailScreen extends StatelessWidget {
  ProductDetail productDetail;
  BuyerProductDetailScreen({required this.productDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _topBody(context)),
        _bottomBody(context),
      ],
    );
  }

  Widget _bottomBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black87.withOpacity(0.4),
          spreadRadius: 10,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ]),
      padding: Dimen.defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            SharedCode(context).formatToNumber(productDetail.product.price),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppThemeData.getTheme(context).primaryColor),
          ),
          Dimen.horizontalSpaceMedium,
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: productDetail.product.stock == 0
                      ? AppColors.grey
                      : AppThemeData.getTheme(context).primaryColor),
              onPressed: () {},
              child: Text(productDetail.product.stock == 0
                  ? "Stok Habis"
                  : "Tambahkan ke Keranjang"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Dimen.mediumRadius),
                bottomRight: Radius.circular(Dimen.mediumRadius)),
            child: Image.file(
              File(productDetail.product.image),
              fit: BoxFit.contain,
              width: double.infinity,
              height: 40.h,
            ),
          ),
          Padding(
            padding: Dimen.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productDetail.product.name,
                    style: Theme.of(context).textTheme.titleLarge),
                Dimen.verticalSpaceSmall,
                Chip(
                    label:
                        Text("Stok tersedia: ${productDetail.product.stock}")),
                Dimen.verticalSpaceSmall,
                const LineSpacing(),
                Dimen.verticalSpaceSmall,
                Text("Nama Toko:",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(productDetail.user.username),
                Dimen.verticalSpaceSmall,
                const LineSpacing(thickness: 1.0),
                Dimen.verticalSpaceSmall,
                Text("Deskripsi Produk:",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(productDetail.product.description),
                Dimen.verticalSpaceSmall,
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Detail Produk"),
      actions: [
        IconButton(
          onPressed: () {
            context.go("/product-buyer/cart");
          },
          icon: const Icon(Icons.shopping_cart_checkout),
        )
      ],
    );
  }
}
