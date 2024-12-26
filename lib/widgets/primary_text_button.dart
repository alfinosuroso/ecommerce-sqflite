import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class PrimaryTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final TextStyle? style;

  const PrimaryTextButton({
    required this.onPressed,
    required this.title,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: style ??
            Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: AppThemeData.getTheme(context).primaryColor),
      ),
    );
  }
}
