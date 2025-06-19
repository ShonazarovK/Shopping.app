import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../text_styles/app_textstyle.dart';
import '../colors/app_colors.dart';
import '../responsivenes/app_responsicenes.dart';

class ActionAppBarWg extends StatelessWidget implements PreferredSizeWidget {
  const ActionAppBarWg({
    super.key,
    this.titleText,
    required this.onBackPressed,
    this.actions,
    this.centerTitle = false,
  });

  final String? titleText;
  final VoidCallback onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      title: Text(
        titleText ?? "",
        style: AppTextStyles.urbanist.bold(
          color: AppColors.black,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        onPressed: onBackPressed,
        icon: Icon(
          IconlyLight.arrow_left,
          size: appH(28),
          color: AppColors.black,
        ),
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
      ),
    );
  }
}