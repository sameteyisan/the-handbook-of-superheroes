import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CColors {
  static const mainColor = Color(0xff3AA6B9);
  static const textColor = Color(0xff181619);
  static const backgroundcolor = Color(0xffF4F2F2);
  static const cardColor = Color(0xffF9EDDE);
  static const dialogColor = Color(0xffCBCBCB);

  static const darkSubtitle = Color(0xff92928E);
  static const borderColor = Color(0xff335373);
  static const sideColor = Color(0x4cb7b7b3);
  static const panelColor = Color(0x1E1F3353);
  static const black = Colors.black;
  static const red = Colors.red;
  static const white = Colors.white;
  static const blue = Color(0xff4267B2);

  static const Map<int, Color> primarySwatchColors = {
    50: Color.fromRGBO(58, 166, 185, .1),
    100: Color.fromRGBO(58, 166, 185, .2),
    200: Color.fromRGBO(58, 166, 185, .3),
    300: Color.fromRGBO(58, 166, 185, .4),
    400: Color.fromRGBO(58, 166, 185, .5),
    500: Color.fromRGBO(58, 166, 185, .6),
    600: Color.fromRGBO(58, 166, 185, .7),
    700: Color.fromRGBO(58, 166, 185, .8),
    800: Color.fromRGBO(58, 166, 185, .9),
    900: Color.fromRGBO(58, 166, 185, 1),
  };

  static const primarySwatch = MaterialColor(0xff0078D4, primarySwatchColors);
}

class Styles {
  static TextStyle get title => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
      );
}
