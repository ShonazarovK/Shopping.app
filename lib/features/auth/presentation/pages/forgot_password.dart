import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:assigment_4/core/common/widgets/button_wg.dart';
import 'package:assigment_4/features/auth/presentation/pages/create_newpassword_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/responsivenes/app_responsicenes.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/route/route_generator.dart';
import '../../../../core/text_styles/app_textstyle.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final List<TextEditingController> _controllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
      onBackPressed: AppRoute.close,),
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Verify Code",
                  style: AppTextStyles.urbanist.bold(color: AppColors.black, fontSize:appH(40))),
            ),
            const Text(
              'Code verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _focusNodes[index].hasFocus
                        ? Colors.blue[100]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _focusNodes[index].hasFocus
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            const Text(
              'Resend code in 55 s',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
           DefaultButtonWg(title: "Verify", onPressed: () =>
               AppRoute.go(const CreateNewpasswordPage()),),
        ],
        ),
      ),
    );
  }
}