import 'package:ecommerce_sqflite/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
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
  int _totalCart = 10;
  List<CartDetail> _cartDetail = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartBloc(CartDao())..add(GetCartByUserId(_user!.id!)),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              _cartDetail.clear();
              _cartDetail.addAll(state.cartDetailsList);
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
        ? _emptyCart()
        : Column(
            children: [
              _topBody(),
              Dimen.verticalSpaceSmall,
              _bottomBody(context),
            ],
          );
  }

  Widget _emptyCart() {
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
            onPressed: () {},
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
                "Rp. 50000",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppThemeData.getTheme(context).primaryColor),
              ),
            ],
          ),
          Dimen.verticalSpaceMedium,
          ElevatedButton(
            onPressed: () {
              context.go("/product-buyer/order-success");
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
          return _buildCartItem(context);
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context) {
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
              child: Image.asset(
                "assets/images/sample-1.jpeg",
                fit: BoxFit.contain,
                width: 30.w,
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
                          "Product Name Long Long LongLongLongLongLongLong",
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
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
                          "Rp. 50.000",
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
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                        color: Colors.black54,
                      ),
                      const Text("10"),
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {},
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
