import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;

  // #region Constructor
  const CustomText._(this.text, {Key? key, this.style = bodyStyle})
      : super(key: key); // Private
  // #endregion

  // #region Factories
  factory CustomText.headingOne(String text) => CustomText._(
        text,
        style: heading1Style,
      );
  factory CustomText.headingTwo(String text) => CustomText._(
        text,
        style: heading2Style,
      );
  factory CustomText.headingThree(String text) => CustomText._(
        text,
        style: heading3Style,
      );
  factory CustomText.headline(String text) => CustomText._(
        text,
        style: headlineStyle,
      );
  factory CustomText.subheading(String text) => CustomText._(
        text,
        style: subheadingStyle,
      );
  factory CustomText.caption(String text) => CustomText._(
        text,
        style: captionStyle,
      );

  factory CustomText.body(String text, {Color color = mediumGreyColor}) =>
      CustomText._(
        text,
        style: bodyStyle.copyWith(color: color),
      );

  // #endregion

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
