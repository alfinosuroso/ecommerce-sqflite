import 'package:flutter/cupertino.dart';

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
    return value.toString().trim().isEmpty ? "Field can't be empty" : null;
  }
}