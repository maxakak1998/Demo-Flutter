import "package:flutter/material.dart";

class TitleTopBarText extends StatelessWidget {
  final String title;

  final Color colorText;

  final double fontSize;
  final double blurRadius = 2.0;
  final double offsetX = 1.0;
  final double offsetY = 1.0;
  final Color colorShadow = Colors.black;
  final bool hasShadow;
  final FontWeight fontWeight;

  const TitleTopBarText(
      {Key key,
      this.title = "Travel",
      this.colorText = Colors.white,
      this.fontSize = 24.0,
      this.fontWeight = FontWeight.bold,
      this.hasShadow = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      title,
      style: TextStyle(shadows: [
        hasShadow
            ? Shadow(
                color: colorShadow,
                offset: Offset(offsetX, offsetY),
                blurRadius: blurRadius)
            : null
      ], fontWeight: fontWeight, fontSize: fontSize, color: colorText),
    );
  }
}
