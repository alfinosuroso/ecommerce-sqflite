import 'package:flutter/material.dart';

class LineSpacing extends StatelessWidget {
  final Color color;
  final double thickness;

  const LineSpacing({
    super.key,
    this.color = Colors.black12, // Default color
    this.thickness = 2.0,        // Default thickness
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color, width: thickness),
        ),
      ),
    );
  }
}
