import 'dart:ui';

import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../text_styles/app_textstyle.dart';
import '../responsivenes/app_responsicenes.dart';

class DefaultButtonWg extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const DefaultButtonWg({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appH(58),
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: AppColors.brown),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTextStyles.urbanist.bold(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
