// import 'package:flutter/material.dart';

// import 'package:ultrasound_clinic/resources/icons.dart' as icons;
// import 'package:ultrasound_clinic/resources/images.dart';
// import 'package:ultrasound_clinic/themes/fonts.dart';
// import 'package:ultrasound_clinic/themes/responsiveness.dart';
// import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

// class CustomAppBarIntro extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBarIntro({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       flexibleSpace: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(Images.frameBackground),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.hs),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hi, Lina Thomas',
//                       style: Theme.of(context).textTheme.headlineMediumWhite,
//                     ),
//                     Text(
//                       'Pending approval (5)',
//                       style: Theme.of(context).textTheme.displaySmallWhite,
//                     ),
//                   ],
//                 ),
//                 const SVGLoader(image: icons.Icons.notification),
//               ],
//             ),
//           ),
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.end,
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Padding(
//           //       padding: const EdgeInsets.only(
//           //         top: 8.0,
//           //         left: 8.0,
//           //         right: 8.0,
//           //         bottom: 12.0,
//           //       ),
//           //       child: Row(
//           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //         children: [
//           //           Transform.scale(
//           //             scale: 0,
//           //             child: IconButton(
//           //               icon: const SVGLoader(image: icons.Icons.back),
//           //               onPressed: () {},
//           //             ),
//           //           ),
//           //           Row(
//           //             crossAxisAlignment: CrossAxisAlignment.center,
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             children: [
//           //               Text(
//           //                 'Balaji Clini',
//           //                 style: Theme.of(context).textTheme.headlineSmallWhite,
//           //               ),
//           //               SizedBox(width: 8.w),
//           //               Row(
//           //                 mainAxisAlignment: MainAxisAlignment.center,
//           //                 crossAxisAlignment: CrossAxisAlignment.center,
//           //                 children: [
//           //                   Text(
//           //                     'XVL560',
//           //                     style: Theme.of(context)
//           //                         .textTheme
//           //                         .displayMediumStrongWhite,
//           //                   ),
//           //                   IconButton(
//           //                     icon: const SVGLoader(image: icons.Icons.copy),
//           //                     onPressed: () {},
//           //                   ),
//           //                 ],
//           //               ),
//           //             ],
//           //           ),
//           //           IconButton(
//           //             icon: const SVGLoader(image: icons.Icons.share),
//           //             onPressed: () {},
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//       elevation: 0,
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomAppBarIntro extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Colors.blue,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi, Lina Thomas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 28,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
                            '5',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Pending approval (5)',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
