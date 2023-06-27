import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CColors {
  static const mainColor = Color(0xff0078D4);
  static const white = Colors.white;
  static const textColor = Color(0xffCECECE);
  static const backgroundcolor = Color(0xff161616);
  static const iconColor = Color(0xff373737);
  static const foregroundBlack = Color(0xff202020);
  static const subtitleColor = Color(0xff979797);
  static const sideColor = Color(0x4cb7b7b3);
  static const indicatorColor = Color(0xff6a6a6a);
  static const disabledColor = Color(0xff393939);

  static const Map<int, Color> primarySwatchColors = {
    50: Color.fromRGBO(0, 120, 212, .1),
    100: Color.fromRGBO(0, 120, 212, .2),
    200: Color.fromRGBO(0, 120, 212, .3),
    300: Color.fromRGBO(0, 120, 212, .4),
    400: Color.fromRGBO(0, 120, 212, .5),
    500: Color.fromRGBO(0, 120, 212, .6),
    600: Color.fromRGBO(0, 120, 212, .7),
    700: Color.fromRGBO(0, 120, 212, .8),
    800: Color.fromRGBO(0, 120, 212, .9),
    900: Color.fromRGBO(0, 120, 212, 1),
  };

  static const primarySwatch = MaterialColor(0xff0078D4, primarySwatchColors);
}

class Styles {
  static TextStyle get title => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
        color: CColors.textColor,
      );

  static TextStyle get bigTitle => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.bold,
        color: CColors.textColor,
      );
}
