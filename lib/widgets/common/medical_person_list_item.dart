import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/medical_persons_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_avatar.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class MedicalPersonListItem extends StatelessWidget {
  final MedicalPersonsModel person;
  final Function(String) navigateToEditScreen;
  final bool isEdit;
  final Function(String doctorId) onDelete;

  const MedicalPersonListItem({
    super.key,
    required this.person,
    required this.navigateToEditScreen,
    required this.isEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      contentPadding: EdgeInsets.zero,
      leading: CustomAvatar(
        imageUrl: person.imageUrl,
        radius: 30.d,
        isNetwork: true,
        isContrast: true,
      ),
      title: Text(
        person.personName,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        person.degree ?? person.designation ?? "",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: isEdit
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const SVGLoader(image: icons.Icons.edit),
                  ),
                  onPressed: () => navigateToEditScreen(person.uid),
                ),
                IconButton(
                  icon: SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const SVGLoader(image: icons.Icons.delete),
                  ),
                  onPressed: () => onDelete(person.uid),
                )
              ],
            )
          : null,
    );
  }
}
