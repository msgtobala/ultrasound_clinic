import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/widgets/common/custom_accordion/custom_expansion_panel_list.dart';

class CustomAccordion extends StatelessWidget {
  final List<ExpansionPanel> children;
  final Function(int index) toggleExpanded;

  const CustomAccordion({
    super.key,
    required this.toggleExpanded,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AppExpansionPanelList(
      elevation: 1,
      dividerColor: ThemeColors.white,
      expansionCallback: (int index, bool isExpanded) => toggleExpanded(index),
      children: children,
    );
  }
}
