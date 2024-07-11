import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.isLoading,
    required this.onSignIn,
  });

  final Future<void> Function(
    String email,
    String password,
  ) onSignIn;
  final bool isLoading;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onSignIn(
        _userEmail,
        _userPassword,
      );
    }
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
              ),
              SizedBox(height: 16.h),
              FormInput(
                text: Strings.enterYourPassword,
                obscureText: true,
                onSaved: (value) => {_userPassword = value!},
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      Strings.forgetYourPassword,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    onTap: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
