import 'package:assigment_4/core/text_styles/urbanist_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/common/responsivenes/app_responsicenes.dart';
import '../../../../core/common/size/app_size.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/common/widgets/button_wg.dart';
import '../../../../core/common/widgets/textfiled_button.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/text_styles/app_textstyle.dart';
import '../../domain/entitiy/profile_entity.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_state.dart';
import '../bloc/profile_event.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(FetchProfileEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: ActionAppBarWg(
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: scaffoldPadding24,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: SpinKitThreeBounce(color: AppColors.brown, size: 24));
              } else if (state is ProfileLoaded) {
                return _buildProfileContent(state.profile);
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(Profile profile) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appH(12)),
          Center(
            child: Text(
              "Complete Your Profile",
              style: AppTextStyles.urbanist.bold(
                color: AppColors.black,
                fontSize: appH(28),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: appH(12)),
          Center(
            child: Text(
              "Don't worry, only you can see your personal data. No one else will be able to see it.",
              style: AppTextStyles.urbanist.medium(
                color: AppColors.grey,
                fontSize: appH(14),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: appH(24)),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: appH(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile.png',
                  width: appW(120),
                  height: appW(120),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, size: 60),
                ),
              ),
            ),
          ),
          SizedBox(height: appH(24)),
          _buildSectionHeader("Name"),
          _buildProfileField(icon: Icons.person, value: profile.name),
          SizedBox(height: appH(16)),
          _buildSectionHeader("Email"),
          _buildProfileField(icon: Icons.email, value: profile.email),
          SizedBox(height: appH(16)),
          _buildSectionHeader("Role"),
          _buildProfileField(
            icon: Icons.work,
            value: profile.role,
            isRole: true,
          ),
          SizedBox(height: appH(32)),
          Center(
            child: DefaultButtonWg(
              title: "Complete Profile",
              onPressed: () {},
            ),
          ),
          SizedBox(height: appH(32)),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String value,
    bool isRole = false,
  }) {
    return CustomTextFieldWg(
      isFocused: false,
      controller: TextEditingController(text: value),
      focusNode: FocusNode(),
      prefixIcon: icon,
      hintText: "",
      trailingWidget: isRole
          ? Icon(Icons.arrow_drop_down, size: appH(20), color: AppColors.black)
          : null,
      obscureText: false,
      validator: (value) {},
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: appH(8)),
      child: Text(
        text,
        style: AppTextStyles.urbanist.semiBold(
          color: AppColors.black,
          fontSize: appH(16),
        ),
      ),
    );
  }
}
