// import 'package:flutter/material.dart';
// import 'dart:io' show Platform;

// abstract class PlatformWidget<A extends Widget, I extends Widget>
//     extends StatelessWidget {
//   // A for Android, I for iOS
//   const PlatformWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isAndroid) {
//       return createAndroidWidget(context);
//     } else if (Platform.isIOS) {
//       return createIosWidget(context);
//     }
//     // platform not supported returns an empty widget
//     return Container();
//   }

//   A createAndroidWidget(BuildContext context);

//   I createIosWidget(BuildContext context);
// }
