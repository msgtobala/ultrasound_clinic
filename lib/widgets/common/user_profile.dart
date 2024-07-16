import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser!;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.s),
          decoration: BoxDecoration(
            color: ThemeColors.white,
            borderRadius: BorderRadius.circular(10.d),
          ),
          child: Row(
            children: [
              // const CircleAvatar(
              //   radius: 38,
              //   backgroundImage: AssetImage('assets/images/clinic_icon.png'),
              // ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${currentUser.name} ${Strings.clinic}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      currentUser.email,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      currentUser.phone,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
