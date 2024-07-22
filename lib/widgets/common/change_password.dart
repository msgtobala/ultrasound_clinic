import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class ChangePasswordWidget extends StatefulWidget {
  final bool isLoading;
  final Function(String email, String oldPassword, String newPassword)
      onChangePassword;

  const ChangePasswordWidget({
    super.key,
    required this.isLoading,
    required this.onChangePassword,
  });

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  String _oldPassword = '';
  String _newPassword = '';

  final _passwordController = TextEditingController();

  void _handleUpdatePassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      widget.onChangePassword(
        authProvider.currentUser!.email,
        _oldPassword,
        _newPassword,
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
              text: Strings.oldPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidPassword;
                }
                return null;
              },
              onSaved: (value) => {_oldPassword = value!},
            ),
            SizedBox(height: 20.h),
            FormInput(
              text: Strings.newPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidPassword;
                }
                return null;
              },
              controller: _passwordController,
              onSaved: (value) => {_newPassword = value!},
            ),
            SizedBox(height: 20.h),
            FormInput(
              text: Strings.confirmNewPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidPassword;
                }

                if (value != _passwordController.text) {
                  return Strings.passwordsDoNotMatch;
                }

                return null;
              },
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.updatePassword,
                onPressed: _handleUpdatePassword,
                isLoading: widget.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
