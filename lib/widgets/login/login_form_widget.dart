import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/resources/images.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/forget_password_screen.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.isLoading,
    required this.onSignIn,
  });

  final Future<void> Function(String email, String password, bool isGoogle)
      onSignIn;
  final bool isLoading;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool isPasswordVisible = true;

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onSignIn(_userEmail, _userPassword, false);
    }
  }

  void _handleGoogleSignIn() {
    widget.onSignIn(_userEmail, _userPassword, true);
  }

  void _revealPassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void onForgetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Container(
          color: ThemeColors.transparent,
          child: Column(
            children: [
              FormInput(
                text: Strings.enterYourEmailOrPhoneNo,
                keyboardType: TextInputType.name,
                onSaved: (value) => {_userEmail = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidEmailOrPhone;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              FormInput(
                text: Strings.enterYourPassword,
                suffixIcon: InkWell(
                  onTap: _revealPassword,
                  child: isPasswordVisible
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.remove_red_eye_outlined),
                ),
                obscureText: isPasswordVisible,
                onSaved: (value) => {_userPassword = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidPassword;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onForgetPassword,
                    child: Text(
                      Strings.forgetYourPassword,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: Strings.login,
                  onPressed: _handleSignIn,
                  isLoading: widget.isLoading,
                ),
              ),
              SizedBox(height: 26.h),
              const CustomDivider(text: Strings.orLoginWithSocialAccount),
              SizedBox(height: 16.h),
              InkWell(
                onTap: _handleGoogleSignIn,
                child: const SVGLoader(image: Images.google),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
