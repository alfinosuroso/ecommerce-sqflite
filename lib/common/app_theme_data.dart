import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = AppColors.primaryBlue;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        fontFamily: 'Montserrat',
        canvasColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        iconTheme: IconThemeData(size: 6.w),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            systemNavigationBarColor: Color(0xFF000000),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 6.w),
          elevation: 0,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimen.radius),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            elevation: 0.0,
            minimumSize: Size(double.infinity, 5.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.radius),
            ),
            textStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black87,
            elevation: 0.0,
            side: const BorderSide(color: Colors.black87, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.radius),
            ),
            minimumSize: Size(double.infinity, 5.h),
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        chipTheme: ChipThemeData(
          selectedColor: primaryColor,
          backgroundColor: AppColors.lightBlue,
          padding: const EdgeInsets.all(5.0),
          brightness: Brightness.light,
          disabledColor: Colors.grey,
          secondarySelectedColor: AppColors.lightBlue,
          secondaryLabelStyle: const TextStyle(
            color: AppColors.bluishBlack,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.darkBlue),
        ),
        // In your app theme file
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 12.sp),
          labelStyle: TextStyle(fontSize: 12.sp),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Set default rounded border to 15
            borderSide:
                BorderSide(color: Colors.black.withOpacity(0.2), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Set enabled border rounded to 15
            borderSide:
                BorderSide(color: Colors.black.withOpacity(0.2), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Set focused border rounded to 15
            borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 2.0), // Blue color when focused
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Set error border rounded to 15
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headlineLarge: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
            buttonColor: AppColors.darkerBlue,
            textTheme: ButtonTextTheme.primary),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
              //<-- SEE HERE
              side: const BorderSide(
                color: AppColors.darkGrey,
              ),
              borderRadius: BorderRadius.circular(25.0)),
          color: Colors.white,
          elevation: 3,
        ));
  }
}
