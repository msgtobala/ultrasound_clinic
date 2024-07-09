import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

// import 'package:ultrasound_clinic/widgets/button.dart';
// import 'package:ultrasound_clinic/widgets/form_input.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormInput(text: Strings.enterYourEmailOrPhoneNo),
            const SizedBox(height: 16),
            const FormInput(text: Strings.enterYourPassword),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.login,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
