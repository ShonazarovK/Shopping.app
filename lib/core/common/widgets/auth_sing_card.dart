import 'package:assigment_4/core/common/widgets/sign_card.dart';
import 'package:flutter/material.dart';

import '../../text_styles/app_textstyle.dart';
import '../colors/app_colors.dart';
import '../responsivenes/app_responsicenes.dart';

class AuthOrContinueWithWg extends StatelessWidget {
  final VoidCallback onTapFacebook;
  final VoidCallback onTapGoogle;
  final VoidCallback onTapApple;

  const AuthOrContinueWithWg({
    super.key,
    required this.onTapFacebook,
    required this.onTapGoogle,
    required this.onTapApple,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Expanded(
      child: Divider(color: AppColors.grey),
    );
    return Column(
      spacing: appH(20),
      children: [
        Row(
          spacing: 20,
          children: [
            divider,
            Text(
              "Or continue with",
              style: AppTextStyles.urbanist.semiBold(
                color: AppColors.greyScale.grey700,
                fontSize: 18,
              ),
            ),
            divider,
          ],
        ),
        Row(
          spacing: appW(20),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthSignInCard(
              imgPath: Image.asset(
                "assets/images/facebook.png",
                width: appH(24),
                height: appH(24),
              ),
              onTap: onTapFacebook,
            ),
            AuthSignInCard(
              imgPath: Image.asset(
                "assets/images/google.png",
                width: appH(24),
                height: appH(24),
              ),
              onTap: onTapGoogle,
            ),
            AuthSignInCard(
              imgPath: Image.asset(
                "assets/images/apple.png",
                width: appH(24),
                height: appH(24),
              ),
              onTap: onTapApple,
            ),
          ],
        ),
      ],
    );
  }
}
