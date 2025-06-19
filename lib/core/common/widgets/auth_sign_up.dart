import 'package:flutter/material.dart';

import '../../text_styles/app_textstyle.dart';
import '../colors/app_colors.dart';

class AuthSignInUpChoiceWg extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const AuthSignInUpChoiceWg(
      {super.key,
        required this.text,
        required this.onPressed,
        required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyles.urbanist
              .regular(color: AppColors.greyScale.grey500, fontSize: 14),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppTextStyles.urbanist
                .semiBold(color: AppColors.brown, fontSize: 14),
          ),
        ),
      ],
    );
  }
}