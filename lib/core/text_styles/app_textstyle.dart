import 'package:assigment_4/core/text_styles/urbanist_textstyle.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static final UrbanistTextStyles urbanist = UrbanistTextStyles();

  TextStyle bold({required Color color, required double fontSize});

  TextStyle semiBold({required Color color, required double fontSize});

  TextStyle medium({required Color color, required double fontSize});

  TextStyle regular({required Color color, required double fontSize});
}
