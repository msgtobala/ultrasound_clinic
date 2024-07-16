import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  void onCopy(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser!;
    final clinicId = currentUser.clinics.first;
    await Clipboard.setData(ClipboardData(text: clinicId));
    if (context.mounted) {
      showSnackbar(context, Strings.clinicCodeCopied);
    }
  }

  void onShare(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser!;
    final clinicId = currentUser.clinics.first;
    final result = await Share.share(clinicId);

    if (result.status == ShareResultStatus.success && context.mounted) {
      showSnackbar(context, Strings.clinicCodeShared);
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(75.h);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser!;

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.frameBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${currentUser.name} ${Strings.clinic}',
                style: Theme.of(context).textTheme.headlineSmallWhite,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentUser.clinics.first,
                      style:
                          Theme.of(context).textTheme.displayMediumStrongWhite,
                    ),
                    IconButton(
                      icon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: SVGLoader(image: icons.Icons.copy),
                      ),
                      onPressed: () => onCopy(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30.vs,
            right: 18.hs,
            child: IconButton(
              icon: const SVGLoader(image: icons.Icons.share),
              onPressed: () => onShare(context),
            ),
          ),
        ],
      ),
      elevation: 0,
    );
  }
}
