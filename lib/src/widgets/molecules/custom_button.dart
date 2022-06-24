import 'dart:developer' show log;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../shared/app_colors.dart';

enum CustomButtonType {
  plain, // text on Android
  outlined, // NOT on iOS // TODO: To implement
  tinted, // and/or gray on iOS, tonal on Android // TODO: To implement
  filled,
  elevated, // NOT on iOS
  realShadow, // TODO: To implement
  toggle,
}

class CustomButton extends StatefulWidget {
  final void Function()? onPressed;
  final String? text;
  final EdgeInsets? padding;
  final CustomButtonType? toggleType1;
  final CustomButtonType? toggleType2;
  final CustomButtonType type;

  // const CustomButton({
  //   Key? key,
  //   required this.onPressed,
  //   this.padding = const EdgeInsets.all(8.0),
  //   this.isFilled = false,
  //   required this.text,
  // })  : toggleFilled = false,
  //       super(key: key);

  const CustomButton.plain({
    Key? key,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    required this.text,
  })  : type = CustomButtonType.plain,
        toggleType1 = null,
        toggleType2 = null,
        super(key: key);

  const CustomButton.filled({
    Key? key,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    required this.text,
  })  : type = CustomButtonType.filled,
        toggleType1 = null,
        toggleType2 = null,
        super(key: key);

  const CustomButton.toggle({
    Key? key,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.toggleType1 = CustomButtonType.filled,
    this.toggleType2 = CustomButtonType.plain,
    required this.text,
  })  : type = CustomButtonType.toggle,
        super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with WidgetsBindingObserver {
  bool _darkMode = false;
  bool _showFilled = false;

  @override
  void initState() {
    super.initState();
    _darkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    WidgetsBinding.instance.addObserver(this);

    _showFilled = widget.type == CustomButtonType.filled ||
        (widget.type == CustomButtonType.toggle &&
            widget.toggleType1 == CustomButtonType.filled);
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
    if (widget.type == CustomButtonType.toggle) {
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
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 16,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      child: PlatformWidget(
        cupertino: (context, __) {
          if (widget.type == CustomButtonType.plain) {
            return CupertinoButton(
              onPressed: _onPressed,
              padding: const EdgeInsets.all(13.0), // Height 48
              child: Text(
                widget.text != null ? widget.text! : '',
                style: TextStyle(
                  color:
                      _darkMode ? defaultIconColorDarkMode : defaultIconColor,
                ),
              ),
            );
          }
          return CupertinoButton(
            onPressed: _onPressed,
            pressedOpacity: widget.type == CustomButtonType.toggle
                ? (_showFilled ? 0.65 : 0.45) + (_darkMode ? 0.15 : 0.0)
                : 0.4,
            padding: const EdgeInsets.all(13.0), // Height 48
            color: _darkMode
                ? _showFilled
                    ? activeBackgroundColorDarkMode
                    : defaultBackgroundColorDarkMode
                : _showFilled
                    ? activeBackgroundColor
                    : defaultBackgroundColor,
            child: Text(
              widget.text != null ? widget.text! : '',
              style: TextStyle(
                color: _darkMode
                    ? _showFilled
                        ? activeIconColorDarkMode
                        : defaultIconColorDarkMode
                    : _showFilled
                        ? activeIconColor
                        : defaultIconColor,
              ),
            ),
          );
        },
        material: (context, __) {
          if (widget.type == CustomButtonType.plain) {
            return TextButton(
              onPressed: _onPressed,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  _darkMode ? defaultIconColorDarkMode : defaultIconColor,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15.0),
                ), // Height 48
              ),
              child: Text(widget.text != null ? widget.text! : ''),
            );
          }
          return ElevatedButton(
            onPressed: _onPressed,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0.0),
              foregroundColor: MaterialStateProperty.all<Color>(
                _darkMode
                    ? _showFilled
                        ? activeIconColorDarkMode
                        : defaultIconColorDarkMode
                    : _showFilled
                        ? activeIconColor
                        : defaultIconColor,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                _darkMode
                    ? _showFilled
                        ? activeBackgroundColorDarkMode
                        : defaultBackgroundColorDarkMode
                    : _showFilled
                        ? activeBackgroundColor
                        : defaultBackgroundColor,
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(15.0),
              ), // Height 48
            ),
            child: Text(widget.text != null ? widget.text! : ''),
          );
        },
      ),
    );
  }
}
