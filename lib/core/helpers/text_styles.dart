import 'package:flutter/material.dart';

import '../constants/color_palatte.dart';

extension ExtendedTextStyle on TextStyle {
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300, fontFamily: AppFonts.rubik);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400, fontFamily: AppFonts.rubik);
  }

  TextStyle get italic {
    return copyWith(
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        fontFamily: AppFonts.rubik);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500, fontFamily: AppFonts.rubik);
  }

  TextStyle get fontHeader {
    return copyWith(fontSize: 22, height: 22 / 20, fontFamily: AppFonts.rubik);
  }

  TextStyle get fontCaption {
    return copyWith(fontSize: 12, height: 12 / 10, fontFamily: AppFonts.rubik);
  }

  TextStyle get semibold {
    return copyWith(fontWeight: FontWeight.w600, fontFamily: AppFonts.rubik);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700, fontFamily: AppFonts.rubik);
  }

  TextStyle get text1Color {
    return copyWith(color: ColorPalette.text1Color, fontFamily: AppFonts.rubik);
  }

  TextStyle get primaryTextColor {
    return copyWith(
        color: ColorPalette.primaryColor, fontFamily: AppFonts.rubik);
  }

  TextStyle get whiteTextColor {
    return copyWith(color: Colors.white, fontFamily: AppFonts.rubik);
  }

  TextStyle get subTitleTextColor {
    return copyWith(
        color: ColorPalette.subTitleColor, fontFamily: AppFonts.rubik);
  }

  // convenience functions
  TextStyle setColor(Color color) {
    return copyWith(color: color, fontFamily: AppFonts.rubik);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size, fontFamily: AppFonts.rubik);
  }
}

class TextStyles {
  TextStyles(this.context);

  BuildContext? context;

  static const TextStyle defaultStyle = TextStyle(
      fontSize: 14,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h1 = TextStyle(
      fontSize: 30,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h2 = TextStyle(
      fontSize: 27.2,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h3 = TextStyle(
      fontSize: 24.4,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h4 = TextStyle(
      fontSize: 21.6,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h5 = TextStyle(
      fontSize: 18.8,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
  static const TextStyle h6 = TextStyle(
      fontSize: 16,
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: AppFonts.rubik);
}

// How to use?
// Text('test text', style: TextStyles.normalText.semibold.whiteColor);
// Text('test text', style: TextStyles.itemText.whiteColor.bold);
class AppFonts {
  static const String rubik = 'Rubik';
}
