import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/router/AppRouter.dart';
import 'package:ecommerce_sqflite/services/dao/product_dao.dart';
import 'package:ecommerce_sqflite/services/dao/user_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, DeviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserBloc(UserDao())..add(CheckUser()),
            ),
            BlocProvider(
              create: (context) => ProductBloc(ProductDao()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Ecommerce Sqflite',
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.getTheme(context),
            routerDelegate: AppRouter().router.routerDelegate,
            routeInformationProvider:
                AppRouter().router.routeInformationProvider,
            routeInformationParser: AppRouter().router.routeInformationParser,
          ),
        );
      },
    );
  }
}
