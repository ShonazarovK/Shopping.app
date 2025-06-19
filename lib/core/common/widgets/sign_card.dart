import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../responsivenes/app_responsicenes.dart';

class AuthSignInCard extends StatelessWidget {
  final Image imgPath;
  final VoidCallback onTap;

  const AuthSignInCard({super.key, required this.imgPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: appW(88),
        height: appH(60),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.greyScale.grey200, width: 1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: appW(32),
          vertical: appH(18),
        ),
        child: imgPath,
      ),
    );
  }
}
