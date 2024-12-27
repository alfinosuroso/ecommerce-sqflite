import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, DeviceType) {
        return MaterialApp.router(
          title: 'Ecommerce Sqflite',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.getTheme(context),
          routerDelegate: AppRouter().router.routerDelegate,
          routeInformationProvider: AppRouter().router.routeInformationProvider,
          routeInformationParser: AppRouter().router.routeInformationParser,
        );
      },
    );
  }
}
