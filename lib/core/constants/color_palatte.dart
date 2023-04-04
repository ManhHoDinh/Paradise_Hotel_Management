import 'package:flutter/material.dart';

class ColorPalette {
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color primaryColor = Color(0xff38A3A5);
  static const Color greenText = Color(0xff57CC99);
  static const Color darkBlueText = Color(0xff22577A);
  static const Color grayText = Color(0xffBFBFBF);
  static const Color blackText = Color(0xff000000);
  static const Color yellowColor = Color(0xffBFBFBF);
  static const Color orangeColor = Color(0xffBFBFBF);
  static const Color calendarGround = Color(0xff002270);
}

// Color(0xff+x) | Mã hex bỏ # ví dụ #123410 => Color(0xFF123410)
class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorPalette.darkBlueText,
      ColorPalette.primaryColor,
    ],
  );
}
