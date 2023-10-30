import 'package:flutter/material.dart';
import 'package:flutter_tut_app/presentation/font_manager.dart';

_getTextStyle(fontSize, fontWeight, color) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

getBlackStyle(fontSize, color) {
  return _getTextStyle(fontSize, FontWeightManager.black, fontSize);
}
