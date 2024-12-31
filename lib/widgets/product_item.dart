import 'dart:io';

import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  final BuildContext context;
  final int index;
  final ProductDetail productDetail;
  final User? user;
  const ProductItem(
      {required this.context,
      required this.index,
      required this.productDetail,
      required this.user,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        user!.role == "Penjual"
            ? context.go("/product-seller/details")
            : context.go("/product-buyer/details");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimen.radius),
              child: Image.file(File(productDetail.product.image),
                  width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Dimen.verticalSpaceSmall,
          Text(
            productDetail.product.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            SharedCode(context).formatToNumber(productDetail.product.price),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppThemeData.getTheme(context).primaryColor,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Dimen.verticalSpaceSmall,
          user!.role == "Pembeli"
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              final bool? isEdited = await context.push(
                                "/product-seller/add-edit",
                                extra: Product(
                                  id: productDetail.product.id,
                                  name: productDetail.product.name,
                                  description:
                                      productDetail.product.description,
                                  image: productDetail.product.image,
                                  price: productDetail.product.price,
                                  stock: productDetail.product.stock,
                                  userId: productDetail.user.id!,
                                ),
                              );
                              if (isEdited == true) {
                                debugPrint("edited");
                                context
                                    .read<ProductBloc>()
                                    .add(GetProductsByUserId(user!.id!));
                              } else {
                                debugPrint("not edited");
                              }
                            },
                            child: const Text("Edit"))),
                    Dimen.horizontalSpaceMedium,
                    PrimaryTextButton(
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.darkRed),
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(DeleteProduct(productDetail.product.id!));
                        context
                            .read<ProductBloc>()
                            .add(GetProductsByUserId(user!.id!));
                      },
                      title: "Hapus",
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
