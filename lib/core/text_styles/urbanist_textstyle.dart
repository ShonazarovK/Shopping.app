import 'package:flutter/material.dart';

import '../common/responsivenes/app_responsicenes.dart';
import 'app_textstyle.dart';
import 'font_familiar.dart';



class UrbanistTextStyles extends AppTextStyles {


  @override
  TextStyle bold({required Color color, required double fontSize}) => TextStyle(
    fontSize: AppResponsive.height(fontSize),
    color: color,
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.urbanist,
  );

  @override
  TextStyle semiBold({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.urbanist,
      );

  @override
  TextStyle medium({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.urbanist,
      );

  @override
  TextStyle regular({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.urbanist,
      );
}
