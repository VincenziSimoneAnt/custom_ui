import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;

  const CustomButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.outline = false,
    this.leading,
  }) : super(key: key); // : outline = false, super(key: key);

  factory CustomButton.outline({
    required String title,
    void Function()? onTap,
    Widget? leading,
  }) =>
      CustomButton(
        title: title,
        disabled: false,
        busy: false,
        onTap: onTap,
        outline: true,
        leading: leading,
      );

  // ? Is better to use a named contructor or a factory in this case?
  // const customButton.outlineX({
  //   required this.title,
  //   this.onTap,
  //   this.leading,
  // })  : disabled = false,
  //       busy = false,
  //       outline = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 48.0,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: (onTap != null) ? primaryColor : mediumGreyColor,
                borderRadius: BorderRadius.circular(8.0),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: primaryColor,
                  width: 1,
                )),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) const SizedBox(width: 5.0),
                  Text(
                    title,
                    style: bodyStyle.copyWith(
                      fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                      color: !outline ? Colors.white : primaryColor,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(
                strokeWidth: 8.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
