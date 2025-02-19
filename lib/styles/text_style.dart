// styles.dart
import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle boldTitleStyle = TextStyle(
    color: Color(0xFF5F0037),
    fontWeight: FontWeight.w700,
    fontFamily: 'OpenSans',
    fontSize: 40,
  );

  static TextStyle titleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    );
  }
}