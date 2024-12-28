import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/widgets/custom_dropdown_text_field.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> _roleList = ["Penjual", "Pembeli"];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            SharedCode(context).successSnackBar(text: state.message);
            context.go("/signin");
          } else if (state is UserError) {
            SharedCode(context).errorSnackBar(text: state.message);
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimen.pagePadding),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Dimen.verticalSpaceSmall,
                  Text("Masukkan email dan password untuk mendaftar",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.darkGrey)),
                  Dimen.verticalSpaceLarge,
                  CustomTextFormField(
                    title: "Username",
                    controller: _usernameController,
                  ),
                  CustomTextFormField(
                    title: "Email",
                    controller: _emailController,
                    validator: SharedCode(context).emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    title: "Password",
                    controller: _passwordController,
                    obsecure: true,
                  ),
                  Dimen.verticalSpaceSmall,
                  DropDownTextField(
                      items: _roleList,
                      onChanged: (v) {
                        setState(() {
                          _roleController.text = v;
                        });
                      },
                      title: "Role Pengguna"),
                  Dimen.verticalSpaceMedium,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newUser = User(
                          id: null,
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          role: _roleController.text,
                        );
                        debugPrint(_roleController.text);
                        context.read<UserBloc>().add(RegisterUser(newUser));
                      }
                      debugPrint("Role: ${_roleController.text}");
                    },
                    child: const Text("Sign Up"),
                  ),
                  Dimen.verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.darkGrey)),
                      PrimaryTextButton(
                        onPressed: () {
                          context.go("/signin");
                        },
                        title: "Login",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
