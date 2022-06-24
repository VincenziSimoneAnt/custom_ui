import 'dart:developer' show log;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// Light theme
const defaultIconColor = Color(0xFF1A2842);
const activeIconColor = Color(0xFFB0BF22);
const defaultBackgroundColor = Colors.transparent;
const activeBackgroundColor = Color(0xFF1A2842);

// Dark theme
const defaultIconColorDarkMode = Color(0xFFFFFFFF);
const activeIconColorDarkMode = Color(0xFF1A2842);
const defaultBackgroundColorDarkMode = Colors.transparent;
const activeBackgroundColorDarkMode = Color(0xFFB0BF22);

class CustomIconButton extends StatefulWidget {
  final IconData? icon;
  final IconData? activeIcon;
  final IconData? materialIcon;
  final IconData? materialActiveIcon;
  final IconData? cupertinoIcon;
  final IconData? cupertinoActiveIcon;
  final EdgeInsets? padding;
  final bool isActive;

  const CustomIconButton({
    Key? key,
    this.icon,
    this.activeIcon,
    this.materialIcon,
    this.materialActiveIcon,
    this.cupertinoIcon,
    this.cupertinoActiveIcon,
    this.padding = const EdgeInsets.all(8.0),
    this.isActive = true,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with WidgetsBindingObserver {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _darkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;

    setState(() {
      _darkMode = brightness == Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: _darkMode
              ? widget.isActive
                  ? activeBackgroundColorDarkMode
                  : defaultBackgroundColorDarkMode
              : widget.isActive
                  ? activeBackgroundColor
                  : defaultBackgroundColor,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 16,
              cornerSmoothing: 0.6,
            ),
          ),
        ),
        child: PlatformIconButton(
          onPressed: () => log('CustomUI info pressed'),
          icon: widget.isActive ? Icon(widget.activeIcon) : Icon(widget.icon),
          padding: widget.padding,
          materialIcon: widget.icon == null
              ? widget.isActive
                  ? Icon(widget.materialActiveIcon)
                  : Icon(widget.materialIcon)
              : null,
          cupertinoIcon: widget.icon == null
              ? widget.isActive
                  ? Icon(
                      widget.cupertinoActiveIcon,
                      color:
                          _darkMode ? activeIconColorDarkMode : activeIconColor,
                    )
                  : Icon(
                      widget.cupertinoIcon,
                      color: _darkMode
                          ? defaultIconColorDarkMode
                          : defaultIconColor,
                    )
              : null,
          material: (_, __) => MaterialIconButtonData(
            color: _darkMode
                ? widget.isActive
                    ? activeIconColorDarkMode
                    : defaultIconColorDarkMode
                : widget.isActive
                    ? activeIconColor
                    : defaultIconColor,
          ),
          cupertino: (_, __) => CupertinoIconButtonData(
            padding: widget.padding != null
                ? widget.padding! + const EdgeInsets.all(4.0)
                : const EdgeInsets.all(4.0),
          ), // color on Cupertino will change the backgroundColor
        ),
      ),
    );
  }
}
