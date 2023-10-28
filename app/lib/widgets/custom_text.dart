import 'package:app/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    this.text = '',
    this.color = Colors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.textOverflow,
    this.onTap,
    this.fontStyle, this.fontFamily, 
    this.decoration
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final dynamic onTap;
  final dynamic fontStyle;
  final dynamic fontFamily;
  final dynamic decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? onTap,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontFamily: fontFamily?? "roboto_sans",
          decoration: decoration,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
      ),
    );
  }
}
