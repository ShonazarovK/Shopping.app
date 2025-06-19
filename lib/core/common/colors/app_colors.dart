import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColors{
  static const Color brown = Color(0xFF8D6E63);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey =Color(0xFF9E9E9E);
  static const greyScale = _GreyScale();


}
class _GreyScale {
  const _GreyScale();

  final Color grey900 = const Color(0xFF212121);
  final Color grey800 = const Color(0xFF424242);
  final Color grey700 = const Color(0xFF616161);
  final Color grey600 = const Color(0xFF757575);
  final Color grey500 = const Color(0xFF9E9E9E);
  final Color grey400 = const Color(0xFFBDBDBD);
  final Color grey300 = const Color(0xFFE0E0E0);
  final Color grey200 = const Color(0xFFEEEEEE);
  final Color grey100 = const Color(0xFFF5F5F5);
  final Color grey50 = const Color(0xFFFAFAFA);

}