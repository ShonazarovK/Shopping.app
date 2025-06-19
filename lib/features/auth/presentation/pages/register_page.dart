import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/common/responsivenes/app_responsicenes.dart';
import '../../../../core/common/size/app_size.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/common/widgets/auth_sign_up.dart';
import '../../../../core/common/widgets/auth_sing_card.dart';
import '../../../../core/common/widgets/button_wg.dart';
import '../../../../core/common/widgets/textfiled_button.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/route/route_generator.dart';
import '../../../../core/text_styles/app_textstyle.dart';
import '../../../../core/utils/logger.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../../data/datasource/local_datasource/auth_local_datasource.dart';
import '../../domain/entitiy/auth_token.dart';
import '../bloc/auth_event.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/register/bloc.dart';
import '../bloc/register/state.dart';
import 'forgot_password.dart';
import 'profile_page.dart';
import 'sing_in_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _obscureText = true;
  final _authLocalDataSource = sl<AuthLocalDataSource>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleEmailFocus);
    _passwordFocusNode.addListener(_handlePasswordFocus);
  }

  void _handleEmailFocus() => setState(() => _isEmailFocused = _emailFocusNode.hasFocus);
  void _handlePasswordFocus() => setState(() => _isPasswordFocused = _passwordFocusNode.hasFocus);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveUserData(Auth auth) async {
    try {
      await _authLocalDataSource.saveRememberMe(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      await _authLocalDataSource.saveAuthToken(auth.refreshToken, auth.accessToken);
      sl<ProfileBloc>().add(FetchProfileEvent());
    } catch (e) {
      LoggerService.error("Error saving data: $e");
    }
  }

  void _onSignInPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<LogInUserBloc>().add(
        LoginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value?.isEmpty ?? true) return 'Enter the email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value!)) {
      return 'Notoʻgʻri email formati';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value?.isEmpty ?? true) return 'Enter the parol';
    if (value!.length < 6) return 'Parol 6 ta belgidan kam';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return BlocListener<LogInUserBloc, LogInUserState>(
      listener: (context, state) {
        if (state is LogInUserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        if (state is LogInUserSuccess) {
          _saveUserData(state.user);
          AppRoute.go(const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ActionAppBarWg(onBackPressed: AppRoute.close),
        body: SingleChildScrollView(
          child: Padding(
            padding: scaffoldPadding24,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Sign in", style: AppTextStyles.urbanist.bold(color: AppColors.black, fontSize: appH(40))),
                  ),
                  Text(
                    "Hi,welcome back ",
                    style: AppTextStyles.urbanist.medium(color: AppColors.greyScale.grey900, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  CustomTextFieldWg(
                    isFocused: _isEmailFocused,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    prefixIcon: IconlyBold.message,
                    hintText: "Email",
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWg(
                    isFocused: _isPasswordFocused,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    prefixIcon: IconlyBold.lock,
                    hintText: "Parol",
                    obscureText: _obscureText,
                    validator: _validatePassword,
                    trailingWidget: IconButton(
                      icon: Icon(
                        _obscureText ? IconlyBold.hide : IconlyBold.show,
                        size: 20,
                      ),
                      color: _isPasswordFocused ? AppColors.brown : AppColors.grey,
                      onPressed: () => setState(() => _obscureText = !_obscureText),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => AppRoute.go(const ForgotPassword()),
                      child: Text("Forgot password?", style: AppTextStyles.urbanist.semiBold(color: AppColors.brown, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<LogInUserBloc, LogInUserState>(
                    builder: (context, state) {
                      if (state is LogInUserLoading) {
                        return const SpinKitThreeBounce(color: AppColors.brown, size: 24);
                      }
                      return DefaultButtonWg(title: "Kirish", onPressed: _onSignInPressed);
                    },
                  ),
                  const SizedBox(height: 32),
                  AuthOrContinueWithWg(
                    onTapFacebook: () {},
                    onTapGoogle: () {},
                    onTapApple: () {},
                  ),
                  AuthSignInUpChoiceWg(
                    text: "Dont you have an account?",
                    buttonText: "Sing up",
                    onPressed: () => AppRoute.replace(const SignUpPage()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
