import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class SignupSuccessfulWidget extends StatefulWidget {
  const SignupSuccessfulWidget({super.key, required this.seconds});

  final int seconds;

  @override
  State<SignupSuccessfulWidget> createState() => _SignupSuccessfulWidgetState();
}

class _SignupSuccessfulWidgetState extends State<SignupSuccessfulWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      pageTitle: '',
      pageDescription: '',
      offset: Offset(0, -60.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SVGLoader(image: Images.successBadge),
          SizedBox(height: 20.h),
          Text(
            Strings.signupSuccessful,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 10.h),
          Text(
            Strings.emailVerificationNotice,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 6.h),
          Text(
            Strings.redirectingTextStart +
                widget.seconds.toString() +
                Strings.redirectingTextEnd,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
