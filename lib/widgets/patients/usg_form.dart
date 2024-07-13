import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class UsgForm extends StatefulWidget {
  const UsgForm({super.key});

  @override
  State<UsgForm> createState() => _UsgFormState();
}

class _UsgFormState extends State<UsgForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormInput(
              text: Strings.patientName,
            ),
            SizedBox(
              height: 20.h,
            ),
            const FormInput(text: Strings.mobileNumber),
            SizedBox(
              height: 20.h,
            ),
            const CustomDashedInput(text: Strings.prescription),
            SizedBox(
              height: 20.h,
            ),
            const FormInput(text: Strings.address),
            SizedBox(
              height: 20.h,
            ),
            const FormInput(text: Strings.city),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const Expanded(
                  child: FormInput(
                    text: Strings.city,
                  ),
                ),
                SizedBox(width: 29.w),
                const Expanded(
                  child: FormInput(
                    text: Strings.pinCode,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.usgSubmit,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
