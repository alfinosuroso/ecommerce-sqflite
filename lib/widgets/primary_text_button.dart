import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class PrimaryTextWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final TextStyle? style;

  const PrimaryTextWidget({
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
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: style ??
            Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: AppColors.primaryBlue),
      ),
    );
  }
}
