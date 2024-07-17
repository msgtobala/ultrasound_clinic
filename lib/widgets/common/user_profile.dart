import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final currentUser = authProvider.currentUser!;
    final String src = currentUser.profileUrl ?? '';
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
              //Todo(should add custom widget for empty image)
              CircleAvatar(
                radius: 38,
                backgroundImage: src.isNotEmpty ? NetworkImage(src) : null,
              ),
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
                icon: const SVGLoader(image: icons.Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(ClinicRoutes.editProfile);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
