import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/widgets/custom_dropdown_text_field.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/primary_text_button.dart';
import 'package:ecommerce_sqflite/widgets/solid_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> _roleList = ["Penjual", "Pembeli"];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimen.pagePadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: Dimen.textSpacing),
              Text("Masukkan email dan password untuk mendaftar",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.darkGrey)),
              const SizedBox(height: Dimen.bigSpacing),
              CustomTextFormField(
                title: "Email",
                controller: _emailController,
                validator: SharedCode(context).emailValidator,
              ),
              CustomTextFormField(
                title: "Password",
                controller: _passwordController,
              ),
              const SizedBox(height: Dimen.textSpacing),
              DropDownTextField(
                  items: _roleList,
                  onChanged: (v) {
                    setState(() {
                      _roleController.text = v;
                    });
                  },
                  title: "Role Pengguna"),
              const SizedBox(height: Dimen.bigSpacing),
              SolidButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("sign up");
                  } else {
                    return null;
                  }
                },
                title: "Sign Up",
              ),
              const SizedBox(height: Dimen.pagePadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.darkGrey)),
                  PrimaryTextWidget(
                    onPressed: () {
                      print("Login button pressed");
                      // Navigator.of(context).push(route)
                    },
                    title: "Login",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
