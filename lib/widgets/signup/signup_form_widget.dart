import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/config/auth/user_role.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class SignupFormWidget extends StatefulWidget {
  final void Function({
    required BuildContext context,
    required String userName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) onSignup;
  final bool? isLoading;

  const SignupFormWidget({super.key, required this.onSignup, this.isLoading});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isTermsAccepted = false;
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  String _phone = '';
  String? _role;

  void _handleRoleChange(String? value) {
    setState(() {
      _role = value;
    });
  }

  void _handleCheckBox(bool? value) {
    setState(() {
      _isTermsAccepted = value!;
    });
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onSignup(
        context: context,
        userName: _userName,
        email: _userEmail,
        phone: _phone,
        password: _userPassword,
        role: _role!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormInput(
              text: Strings.fullName,
              keyboardType: TextInputType.name,
              onSaved: (value) => {_userName = value!},
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {_userEmail = value!},
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.mobileNumber,
              keyboardType: TextInputType.phone,
              onSaved: (value) => {_phone = value!},
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    Strings.selectYourRole,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            Row(
              children: userRoles.map((role) {
                return Expanded(
                  child: RadioListTile(
                    title: Text(
                      role.roleName,
                      style:
                          Theme.of(context).textTheme.headlineSmallRegularGrey,
                    ),
                    value: role.roleConstant,
                    groupValue: _role,
                    contentPadding: EdgeInsets.zero,
                    dense: false,
                    visualDensity: const VisualDensity(horizontal: -4),
                    activeColor: ThemeColors.black,
                    onChanged: _handleRoleChange,
                  ),
                );
              }).toList(),
            ),
            FormInput(
              text: Strings.password,
              keyboardType: TextInputType.text,
              onSaved: (value) => {_userPassword = value!},
            ),
            const SizedBox(height: 20),
            const FormInput(
              text: Strings.confirmPassword,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  activeColor: ThemeColors.black,
                  onChanged: _handleCheckBox,
                ),
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.iAgreeWithThe,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: Strings.termsAndConditions,
                          style: Theme.of(context).textTheme.bodyMediumPrimary,
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.register,
                onPressed: _handleSignup,
                isLoading: widget.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
