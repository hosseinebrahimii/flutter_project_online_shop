import 'package:flutter/material.dart';

class ColorMaker {
  static Color makeColor(String value) {
    int colorHexCode = int.parse(value, radix: 16);
    return Color(0xff000000 + colorHexCode);
  }
}
