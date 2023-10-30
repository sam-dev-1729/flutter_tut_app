import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color white = HexColor.fromHex("#FFFFFF");
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceAll("#", '');
    if (hexString.length == 6) {
      hexString = "FF" + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
