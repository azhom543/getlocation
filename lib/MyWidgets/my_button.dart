import 'package:flutter/material.dart';
import 'package:getlocation/MyWidgets/my_text.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final onPressed;
  final text;
  final textColor;
  final textSize;
  final fillColor;
  final fontWeight;
  final shadow;
  final buttonWidth;
  final borderRadius;

  const MyButton(
      {Key? key,
      this.text,
      this.buttonWidth,
      this.textSize,
      this.fontWeight,
      this.shadow,
      this.textColor,
      this.fillColor,
      this.borderRadius,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: buttonWidth ?? double.infinity,
      child: RawMaterialButton(
        elevation: shadow ?? 0.0,
        focusElevation: 0.0,
        hoverElevation: 0.0,
        highlightElevation: 0.0,
        onPressed: onPressed,
        child: MyText(
          text: text,
          size: textSize ?? 15.0,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? K_whiteColor,
        ),
        fillColor: fillColor ?? K_blackColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? K_radius)),
      ),
    );
  }
}
