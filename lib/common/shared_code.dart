import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedCode {
  final BuildContext context;

  SharedCode(this.context);

  String? emailValidator(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? "Email is not valid" : null;
  }

  String? emptyValidator(value) {
    return value.toString().trim().isEmpty || value == null
        ? "Field can't be empty"
        : null;
  }

  void successSnackBar({
    required String text,
  }) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: AppColors.green,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void errorSnackBar({
    required String text,
  }) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: AppColors.darkRed,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
