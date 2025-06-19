import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/common/responsivenes/app_responsicenes.dart';
import '../../../../core/text_styles/app_textstyle.dart';

class ChooseWg extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String label;
  final bool showIcon;
  final void Function(bool)? onSelected;

  const ChooseWg({
    super.key,
    required this.index,
    required this.label,
    required this.selectedIndex,
    required this.onSelected,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: appW(12)),
      child: ChoiceChip(
        label: Text(
          label,
          style: AppTextStyles.urbanist.semiBold(
            color:
            selectedIndex == index ? AppColors.white : AppColors.brown,
            fontSize: 16,
          ),
        ),
        selected: selectedIndex == index,
        selectedColor: AppColors.brown,
        backgroundColor: AppColors.white,
        showCheckmark: false,
        avatar: showIcon
            ? Icon(
          IconlyBold.star,
          color: selectedIndex == index
              ? AppColors.white
              : AppColors.brown,
        )
            : null,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.brown),
          borderRadius: BorderRadius.circular(100),
        ),
        onSelected: onSelected,
      ),
    );
  }
}
