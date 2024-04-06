import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  Text title(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          height: 1.5, fontSize: 31, color: color, fontWeight: FontWeight.w500),
    );
  }

  Text head(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          height: 1.5, fontSize: 45, color: color, fontWeight: FontWeight.w500),
    );
  }

  Text subTitle(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 22, color: color, fontWeight: FontWeight.bold),
    );
  }

  Text subTitle4(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 19,
          color: const Color(0xfff1A1A1A),
          fontWeight: FontWeight.bold),
    );
  }

  Text subTitle2(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.raleway(
          fontSize: 16, color: Color(0xfff273240), fontWeight: FontWeight.w300),
    );
  }

  Text subTitleOther(String text, Color color, double? size,
      FontWeight fontWeight, TextAlign textAlign) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.raleway(
          fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  Text subTitle3(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.raleway(
          fontSize: 16, color: color, fontWeight: FontWeight.w500),
    );
  }

  Text normalText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 14,
          color: color,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
    );
  }

  Text premiumQuoteText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 14,
          color: const Color(0xfff566370),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
    );
  }

  Text boldnormalText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 15, color: Color(0xfff273240), fontWeight: FontWeight.w500),
    );
  }

  Text boldnormalText2(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: 17, color: color, fontWeight: FontWeight.w700),
    );
  }

  Text boldnormalText3(String text, Color color, double size) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontSize: size, color: color, fontWeight: FontWeight.w500),
    );
  }

  Text customizableTex(
    String text,
    Color color,
    FontWeight fontWeight,
    double fontSize,
  ) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      // overflow: TextOverflow.fade,
      // maxLines: 2,
      softWrap: true, // Allow text to wrap to a new line if it overflows
    );
  }
}
