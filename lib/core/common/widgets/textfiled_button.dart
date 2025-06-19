import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../text_styles/app_textstyle.dart';
import '../responsivenes/app_responsicenes.dart';

class CustomTextFieldWg extends StatelessWidget {
  final bool isFocused;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final String hintText;
  final VoidCallback? onTap;
  final Widget? trailingWidget;
  final bool obscureText;

  const CustomTextFieldWg(
      {super.key,
        required this.isFocused,
        required this.controller,
        required this.focusNode,
        required this.prefixIcon,
        required this.hintText,
        this.onTap,
        this.trailingWidget,
        this.obscureText = false, required String? Function(String? value) validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appH(60),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: appW(20)),
      decoration: BoxDecoration(
        color:
        isFocused ? AppColors.greyScale.grey300  : AppColors.greyScale.grey100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            width: isFocused ? 2 : 0,
            color:
            isFocused ? AppColors.brown : AppColors.grey),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        style: AppTextStyles.urbanist
            .semiBold(color: AppColors.grey, fontSize: 14),
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffix: trailingWidget,
          icon: Icon(
            prefixIcon,
            size: appH(20),
            color:
            isFocused ? AppColors.brown : AppColors.grey,
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.urbanist.medium(
            color: AppColors.brown,
            fontSize: 14,
          ),
          border: InputBorder.none,
        ),
        onTap: onTap,
        onSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}