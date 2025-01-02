import 'dart:io';

import 'package:ecommerce_sqflite/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/cart_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/cart_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final User? _user = AuthService.getUser();
  List<CartDetail> _cartDetail = [];
  int _totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartBloc(CartDao())..add(GetCartByUserId(_user!.id!)),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartSuccess) {
              SharedCode(context).successSnackBar(text: state.message);
            } else if (state is CartError) {
              SharedCode(context).errorSnackBar(text: state.message);
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              debugPrint("loaded");
              _cartDetail.clear();
              _cartDetail.addAll(state.cartDetailsList);
              _totalPrice = _cartDetail.fold(
                  0,
                  (previousValue, element) =>
                      previousValue +
                      (element.product.price * element.cart.quantity));
              debugPrint("cart detail:${_cartDetail.length}");
              return _buildBody(context);
            }
            return _buildBody(context);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _cartDetail.isEmpty
        ? _emptyCart(context)
        : Column(
            children: [
              _topBody(),
              Dimen.verticalSpaceSmall,
              _bottomBody(context),
            ],
          );
  }

  Widget _emptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.bagShopping,
            size: 35.w,
            color: AppThemeData.getTheme(context).primaryColor,
          ),
          Dimen.verticalSpaceMedium,
          Text(
            "Keranjang Kosong",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Dimen.verticalSpaceMedium,
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(20.w, 5.h)),
            onPressed: () {
              context.go("/product-buyer");
            },
            child: const Text("Cari Produk"),
          ),
          Dimen.verticalSpaceLarge,
        ],
      ),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                SharedCode(context).formatToNumber(_totalPrice),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppThemeData.getTheme(context).primaryColor),
              ),
            ],
          ),
          Dimen.verticalSpaceMedium,
          ElevatedButton(
            onPressed: () {
              context.go("/product-buyer/order-success");
              context.read<CartBloc>().add(CheckoutCart(_user!.id!));
            },
            child: const Text("Bayar Sekarang"),
          ),
        ],
      ),
    );
  }

  Expanded _topBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: _cartDetail.length,
        itemBuilder: (context, index) {
          return _buildCartItem(context, index);
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimen.radius),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: Dimen.smallPadding,
        margin: Dimen.defaultMargin,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimen.radius),
              child: Image.file(
                File(_cartDetail[index].product.image),
                fit: BoxFit.contain,
                width: 30.w,
                height: 10.h,
              ),
            ),
            Dimen.horizontalSpaceSmall,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _cartDetail[index].product.name,
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(DeleteCart(
                              _cartDetail[index].cart.id!, _user!.id!));
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          SharedCode(context)
                              .formatToNumber(_cartDetail[index].product.price),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: AppThemeData.getTheme(context)
                                      .primaryColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          context.read<CartBloc>().add(UpdateCart(Cart(
                              id: _cartDetail[index].cart.id,
                              userId: _user!.id!,
                              productId: _cartDetail[index].product.id!,
                              quantity: _cartDetail[index].cart.quantity - 1)));
                        },
                        icon: const Icon(Icons.remove),
                        color: Colors.black54,
                      ),
                      Text(_cartDetail[index].cart.quantity.toString()),
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            context.read<CartBloc>().add(UpdateCart(Cart(
                                id: _cartDetail[index].cart.id,
                                userId: _user!.id!,
                                productId: _cartDetail[index].product.id!,
                                quantity:
                                    _cartDetail[index].cart.quantity + 1)));
                          },
                          icon: const Icon(Icons.add, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Keranjang"),
    );
  }
}
