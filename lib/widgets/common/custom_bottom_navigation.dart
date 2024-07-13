import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavigationChanged;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onNavigationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.d),
          topLeft: Radius.circular(20.d),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(31, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 100,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          items: constants.bottomNavigation
              .map(
                (ele) => BottomNavigationBarItem(
                  icon: SizedBox(
                    width: ele.width,
                    height: ele.height,
                    child: SVGLoader(image: ele.icon),
                  ),
                  activeIcon: SizedBox(
                    width: ele.width,
                    height: ele.height,
                    child: SVGLoader(image: ele.activeIcon),
                  ),
                  label: ele.label,
                ),
              )
              .toList(),
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          selectedFontSize: 12.f,
          unselectedFontSize: 12.f,
          iconSize: 20.ics,
          selectedItemColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(height: 2.5),
          unselectedLabelStyle: const TextStyle(height: 2.5),
          onTap: onNavigationChanged,
        ),
      ),
    );
  }
}
