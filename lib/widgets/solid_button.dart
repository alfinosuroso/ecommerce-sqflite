import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const SolidButton({required this.onPressed, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
