import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/routes/patient_routes.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/widgets/common/custom_avatar.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class UserProfileCard extends StatelessWidget {
  final bool? isClinic;

  const UserProfileCard({
    super.key,
    required this.isClinic,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final currentUser = authProvider.currentUser!;
    final String src = currentUser.profileUrl ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: EdgeInsets.only(left: 18.hs, right: 18.hs, top: 35.vs),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.d),
          ),
          child: Padding(
            padding: EdgeInsets.all(18.hs),
            child: Row(
              children: [
                CustomAvatar(
                  imageUrl: src,
                  radius: 38.d,
                  isContrast: true,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${currentUser.name} ${isClinic == true ? Strings.clinic : ''}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        currentUser.email,
                        style: Theme.of(context).textTheme.bodySmallBlack,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        currentUser.phone,
                        style: Theme.of(context).textTheme.bodySmallBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  icon: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const SVGLoader(image: icons.Icons.edit),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      isClinic!
                          ? ClinicRoutes.editProfile
                          : PatientRoutes.editProfile,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
