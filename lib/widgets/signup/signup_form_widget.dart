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
  String? _roleError;
  String? _isTermsAcceptedError;

  final _passwordController = TextEditingController();

  void _handleRoleChange(String? value) {
    setState(() {
      _role = value;
      _roleError = null;
    });
  }

  void _handleCheckBox(bool? value) {
    setState(() {
      _isTermsAccepted = value!;
      _isTermsAcceptedError = null;
    });
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate() &&
        _role != null &&
        _isTermsAccepted) {
      _formKey.currentState?.save();
      widget.onSignup(
        context: context,
        userName: _userName,
        email: _userEmail,
        phone: _phone,
        password: _userPassword,
        role: _role!,
      );
    } else if (_role == null) {
      setState(() {
        _roleError = Strings.pleaseSelectRole;
      });
    } else if (!_isTermsAccepted) {
      setState(() {
        _isTermsAcceptedError = "Please read the terms and agree!";
      });
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidFullName;
                }
                return null;
              },
              onSaved: (value) => {_userName = value!},
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {_userEmail = value!},
              validator: (value) {
                // const emailPattern =
                //     r'^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$';
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return Strings.invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.mobileNumber,
              keyboardType: TextInputType.phone,
              onSaved: (value) => {_phone = value!},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return Strings.invalidMobileNumber;
                }
                return null;
              },
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
            if (_roleError != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  _roleError!,
                  style: TextStyle(color: ThemeColors.errorColor, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.password,
              keyboardType: TextInputType.text,
              onSaved: (value) => {_userPassword = value!},
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return Strings.passwordValidationString;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.confirmPassword,
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return Strings.passwordsShouldMatch;
                }
                return null;
              },
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
            if (_isTermsAcceptedError != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  _isTermsAcceptedError!,
                  style: TextStyle(color: ThemeColors.errorColor, fontSize: 12),
                ),
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
