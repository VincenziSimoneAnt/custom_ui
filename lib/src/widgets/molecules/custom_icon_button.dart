import 'dart:developer' show log;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../shared/app_colors.dart';

class CustomIconButton extends StatefulWidget {
  final void Function()? onPressed;
  final IconData? icon;
  final IconData? activeIcon;
  final IconData? materialIcon;
  final IconData? materialActiveIcon;
  final IconData? cupertinoIcon;
  final IconData? cupertinoActiveIcon;
  final EdgeInsets? padding;
  final bool isFilled;
  final bool toggleFilled;

  // const CustomIconButton({
  //   Key? key,
  //   required this.onPressed,
  //   this.icon,
  //   this.activeIcon,
  //   this.materialIcon,
  //   this.materialActiveIcon,
  //   this.cupertinoIcon,
  //   this.cupertinoActiveIcon,
  //   this.padding = const EdgeInsets.all(8.0),
  //   this.isFilled = false,
  // })  : toggleFilled = false,
  //       super(key: key);

  const CustomIconButton.plain({
    Key? key,
    required this.onPressed,
    this.icon,
    this.activeIcon,
    this.materialIcon,
    this.materialActiveIcon,
    this.cupertinoIcon,
    this.cupertinoActiveIcon,
    this.padding = const EdgeInsets.all(8.0),
  })  : isFilled = false,
        toggleFilled = false,
        super(key: key);

  const CustomIconButton.filled({
    Key? key,
    required this.onPressed,
    this.icon,
    this.activeIcon,
    this.materialIcon,
    this.materialActiveIcon,
    this.cupertinoIcon,
    this.cupertinoActiveIcon,
    this.padding = const EdgeInsets.all(8.0),
  })  : isFilled = true,
        toggleFilled = false,
        super(key: key);

  const CustomIconButton.toggle({
    Key? key,
    required this.onPressed,
    this.icon,
    this.activeIcon,
    this.materialIcon,
    this.materialActiveIcon,
    this.cupertinoIcon,
    this.cupertinoActiveIcon,
    this.padding = const EdgeInsets.all(8.0),
    this.isFilled = false,
  })  : toggleFilled = true,
        super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with WidgetsBindingObserver {
  bool _darkMode = false;
  bool _showFilled = false;

  @override
  void initState() {
    super.initState();
    _darkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    WidgetsBinding.instance.addObserver(this);

    _showFilled = widget.isFilled;
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

  void _onPressed() {
    if (widget.toggleFilled) {
      setState(() {
        _showFilled = !_showFilled;
      });
    }
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: _darkMode
              ? _showFilled
                  ? activeBackgroundColorDarkMode
                  : defaultBackgroundColorDarkMode
              : _showFilled
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
          onPressed: _onPressed,
          icon: _showFilled ? Icon(widget.activeIcon) : Icon(widget.icon),
          padding: widget.padding,
          materialIcon: widget.icon == null
              ? _showFilled
                  ? Icon(widget.materialActiveIcon)
                  : Icon(widget.materialIcon)
              : null,
          cupertinoIcon: widget.icon == null
              ? _showFilled
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
                ? _showFilled
                    ? activeIconColorDarkMode
                    : defaultIconColorDarkMode
                : _showFilled
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
