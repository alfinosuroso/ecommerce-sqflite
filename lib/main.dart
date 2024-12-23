import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/screens/sign_in_screen.dart';
import 'package:ecommerce_sqflite/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      initialLocation: "/signup",
      routes: [
        GoRoute(
          name: "signup",
          path: "/signup",
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: "signin",
          path: "/signin",
          builder: (context, state) => const SignInScreen(),
        )
      ]);
    return Sizer(
      builder: (context, orientation, DeviceType) {
        return MaterialApp.router(
          title: 'Ecommerce Sqflite',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.getTheme(context),
          routerConfig: _router,
        );
      },
    );
  }
}