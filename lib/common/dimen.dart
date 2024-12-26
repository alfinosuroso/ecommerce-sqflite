import 'package:flutter/cupertino.dart';


class Dimen {
  // Default padding and margin values
  static const double pagePadding = 20.0;
  static const double screenPadding = 24.0;
  static const double textSpacing = 8.0;
  static const double mediumSpacing = 12.0;
  static const double bigSpacing = 32.0;
  static const double radius = 16.0;
  static const double mediumRadius = 25.0;

  // Custom padding
  static EdgeInsets defaultPadding = const EdgeInsets.all(pagePadding);
  static EdgeInsets horizontalPadding = const EdgeInsets.symmetric(horizontal: screenPadding);
  static EdgeInsets verticalPaddingMedium = const EdgeInsets.symmetric(vertical: screenPadding);
  static EdgeInsets verticalPaddingSmall = const EdgeInsets.symmetric(vertical: textSpacing);

  // Spacing for widgets like SizedBox
  static Widget verticalSpaceSmall = const SizedBox(height: 8.0);
  static Widget verticalSpaceMedium = const SizedBox(height: 16.0);
  static Widget verticalSpaceLarge = const SizedBox(height: 32.0);
  
  static Widget horizontalSpaceSmall = const SizedBox(width: 8.0);
  static Widget horizontalSpaceMedium = const SizedBox(width: 16.0);
  static Widget horizontalSpaceLarge = const SizedBox(width: 32.0);
}
