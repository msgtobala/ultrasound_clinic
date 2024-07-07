import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ultrasound_clinic/resources/strings.dart';

// import 'package:ultrasound_clinic/widgets/custom_divider.dart';
// import 'package:ultrasound_clinic/widgets/signup_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 320.h,
                child: const Stack(
                  children: [
                    // Image.asset('placeholder'),
                    Column(
                      children: [
                        Text(Strings.signIn),
                        Text("Enter your user name and password to login!")
                      ],
                    )
                  ],
                ),
              ),
              // const SignupForm(),
              const SizedBox(height: 10),
              // const CustomDivider(
              //   text: "Or register with your social account",
              // ),
              const SizedBox(
                height: 16,
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(MdiIcons.google),
              // ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ?  "),
                  GestureDetector(
                    child: const Text(
                      " Login now",
                      style: TextStyle(
                        color: Color(0xFF2BAFFC),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
