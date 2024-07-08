import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/otp_verification_screen.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _role;
  bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormInput(text: Strings.fullName),
            SizedBox(height: 20.px),
            const FormInput(text: Strings.email),
            SizedBox(height: 20.px),
            const FormInput(text: Strings.mobileNumber),
            SizedBox(height: 20.px),
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
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      Strings.patient,
                      style:
                          Theme.of(context).textTheme.headlineSmallRegularGrey,
                    ),
                    value: Strings.patient,
                    groupValue: _role,
                    contentPadding: EdgeInsets.zero,
                    activeColor: ThemeColors.black,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      Strings.clinic,
                      style:
                          Theme.of(context).textTheme.headlineSmallRegularGrey,
                    ), //todo
                    value: Strings.clinic,
                    groupValue: _role,
                    activeColor: ThemeColors.black,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const FormInput(text: Strings.password),
            SizedBox(
              height: 20.px,
            ),
            const FormInput(text: Strings.confirmPassword),
            SizedBox(
              height: 20.px,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  activeColor: ThemeColors.black,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      _isTermsAccepted = value!;
                    });
                  },
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Test");
                            },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.px,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.register,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const OtpVerificationScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
