import 'dart:io';

import 'package:ecommerce_sqflite/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProductDetailScreen extends StatefulWidget {
  ProductDetail productDetail;
  UserProductDetailScreen({required this.productDetail, super.key});

  @override
  State<UserProductDetailScreen> createState() =>
      _UserProductDetailScreenState();
}

class _UserProductDetailScreenState extends State<UserProductDetailScreen> {
  User? _user = AuthService.getUser();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartSuccess) {
          SharedCode(context).successSnackBar(text: state.message);
        } else if (state is CartError) {
          SharedCode(context).errorSnackBar(text: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        );
      },
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
            SharedCode(context)
                .formatToNumber(widget.productDetail.product.price),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppThemeData.getTheme(context).primaryColor),
          ),
          if (_user?.role == "Pembeli") ...[
            Dimen.horizontalSpaceMedium,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.productDetail.product.stock == 0
                        ? AppColors.grey
                        : AppThemeData.getTheme(context).primaryColor),
                onPressed: () {
                  widget.productDetail.product.stock == 0
                      ? null
                      : context.read<CartBloc>().add(AddToCart(Cart(
                            userId: _user!.id!,
                            productId: widget.productDetail.product.id!,
                            quantity: 1,
                          )));
                },
                child: Text(widget.productDetail.product.stock == 0
                    ? "Stok Habis"
                    : "Tambahkan ke Keranjang"),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _topBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(Dimen.mediumRadius),
                    bottomRight: Radius.circular(Dimen.mediumRadius)),
                child: Image.file(
                  File(widget.productDetail.product.image),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 40.h,
                ),
              ),
              widget.productDetail.product.stock == 0
                  ? Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimen.mediumRadius),
                            bottomRight: Radius.circular(Dimen.mediumRadius)),
                      ),
                      child: Center(
                        child: Text(
                          "Stok Habis",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: Dimen.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productDetail.product.name,
                    style: Theme.of(context).textTheme.titleLarge),
                Dimen.verticalSpaceSmall,
                Chip(
                    // backgroundColor: Colors.red[300],
                    label: Text(
                        "Stok tersedia: ${widget.productDetail.product.stock}")),
                Dimen.verticalSpaceSmall,
                const LineSpacing(),
                Dimen.verticalSpaceSmall,
                Text("Nama Toko:",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(widget.productDetail.user.username),
                Dimen.verticalSpaceSmall,
                const LineSpacing(thickness: 1.0),
                Dimen.verticalSpaceSmall,
                Text("Deskripsi Produk:",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(widget.productDetail.product.description),
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
        actions: _user?.role == "Pembeli"
            ? [
                IconButton(
                  onPressed: () {
                    context.go("/product-buyer/cart");
                  },
                  icon: const FaIcon(FontAwesomeIcons.cartShopping),
                )
              ]
            : null);
  }
}
