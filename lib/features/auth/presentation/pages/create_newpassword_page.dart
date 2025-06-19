import 'package:assigment_4/core/common/widgets/button_wg.dart';
import 'package:assigment_4/core/common/widgets/textfiled_button.dart';
import 'package:assigment_4/features/auth/presentation/pages/sing_in_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/route/route_generator.dart';

class CreateNewpasswordPage extends StatefulWidget {
  const CreateNewpasswordPage({super.key});

  @override
  State<CreateNewpasswordPage> createState() => _CreateNewpasswordPageState();
}

class _CreateNewpasswordPageState extends State<CreateNewpasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() => _isEmailFocused = _emailFocusNode.hasFocus);
    });
    _passwordFocusNode.addListener(() {
      setState(() => _isPasswordFocused = _passwordFocusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ActionAppBarWg(
        onBackPressed: AppRoute.close,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "New Password",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Fill the new passwords",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 24),
            CustomTextFieldWg(
              isFocused: _isEmailFocused,
              controller: _emailController,
              focusNode: _emailFocusNode,
              prefixIcon: IconlyBold.message,
              hintText: "Password", validator: (String? value) {  },
            ),
            const SizedBox(height: 16),
            CustomTextFieldWg(
              isFocused: _isPasswordFocused,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              prefixIcon: IconlyBold.lock,
              hintText: "New Password",
              obscureText: _obscureText,
              trailingWidget: IconButton(
                icon: Icon(
                  _obscureText ? IconlyBold.hide : IconlyBold.show,
                  size: 20,
                ),
                color: _isPasswordFocused ? AppColors.brown : AppColors.grey,
                onPressed: () => setState(() => _obscureText = !_obscureText),
              ), validator: (String? value) {  },
            ),
            const SizedBox(height: 16),
            DefaultButtonWg(title: "Create New Password", onPressed:  () => AppRoute.replace(const SignUpPage()),),
          ],
        ),
      ),
    );
  }
}