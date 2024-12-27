import 'package:ecommerce_sqflite/screens/buyer/order_success_screen.dart';
import 'package:ecommerce_sqflite/screens/seller/seller_product_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_sqflite/screens/buyer/buyer_product_detail_screen.dart';
import 'package:ecommerce_sqflite/screens/buyer/buyer_product_list_screen.dart';
import 'package:ecommerce_sqflite/screens/buyer/cart_screen.dart';
import 'package:ecommerce_sqflite/screens/home_screen.dart';
import 'package:ecommerce_sqflite/screens/sign_in_screen.dart';
import 'package:ecommerce_sqflite/screens/sign_up_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: "product-buyer",
        path: "/product-buyer",
        builder: (context, state) => const BuyerProductListScreen(),
        routes: [
          GoRoute(
            name: "details",
            path: "details",
            builder: (context, state) => const BuyerProductDetailScreen(),
          ),
          GoRoute(
            name: "cart",
            path: "cart",
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            name: "order-success",
            path: "order-success",
            builder: (context, state) => const OrderSuccessScreen(),
          ),
        ],
      ),
      GoRoute(
          name: "product-seller",
          path: "/product-seller",
          builder: (context, state) => const SellerProductListScreen(),
          routes: []),
      GoRoute(
        name: "signup",
        path: "/signup",
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: "signin",
        path: "/signin",
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );

  GoRouter get router => _router;
}
