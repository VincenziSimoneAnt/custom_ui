import 'dart:developer' show log;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const defaultIconColor = Color(0xFF1A2842);
const activeIconColor = Color(0xFFB0BF22);
const defaultBackgroundColor = Colors.transparent;
const activeBackgroundColor = Color(0xFF1A2842);

class CustomIconButton extends StatelessWidget {
  final Widget? icon;
  final Widget? activeIcon;
  final Widget? materialIcon;
  final Widget? materialActiveIcon;
  final Widget? cupertinoIcon;
  final Widget? cupertinoActiveIcon;
  final bool isActive;
  const CustomIconButton({
    Key? key,
    this.icon,
    this.activeIcon,
    this.materialIcon,
    this.materialActiveIcon,
    this.cupertinoIcon,
    this.cupertinoActiveIcon,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: isActive ? activeBackgroundColor : defaultBackgroundColor,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 16,
              cornerSmoothing: 0.6,
            ),
          ),
        ),
        child: PlatformIconButton(
          onPressed: () => log('CustomUI info pressed'),
          color: isActive ? activeIconColor : defaultIconColor,
          icon: isActive ? activeIcon : icon,
          materialIcon: icon == null
              ? isActive
                  ? materialActiveIcon
                  : materialIcon
              : null,
          cupertinoIcon: icon == null
              ? isActive
                  ? cupertinoActiveIcon
                  : cupertinoIcon
              : null,
          material: (_, __) => MaterialIconButtonData(),
          cupertino: (_, __) => CupertinoIconButtonData(),
        ),
      ),
    );
  }
}
