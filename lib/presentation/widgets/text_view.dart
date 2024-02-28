import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final String? fontFamily;

  const TextView({
    super.key,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize,
    this.letterSpacing = 0.5,
    this.textStyle,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.decoration,
    this.decorationStyle,
    this.shadows,
    this.decorationThickness,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: textStyle ??
            GoogleFonts.comfortaa(
              textStyle: TextStyle(
                fontFamily: fontFamily,
                color: color ?? Colors.black,
                shadows: shadows,
                decoration: decoration,
                decorationStyle: decorationStyle,
                decorationThickness: decorationThickness,
                fontWeight: fontWeight,
                fontSize: fontSize ?? 14,
                fontStyle: fontStyle,
                letterSpacing: letterSpacing,
              ),
            ),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
