import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  BodyText({
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.text,
    Key? key,
  }) : super(key: key);
  FontWeight fontWeight;
  double fontSize;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
