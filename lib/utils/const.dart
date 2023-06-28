import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';

class Const {
  static final powerstatColors = <String, Color>{
    'intelligence': CColors.mainColor,
    'strength': Colors.red,
    'speed': CColors.textColor,
    'durability': Colors.teal,
    'power': Colors.amber,
    'combat': Colors.green,
  };

  static final shadows = [
    Shadow(
      offset: const Offset(1, 1),
      blurRadius: 4.0,
      color: Colors.black.withOpacity(0.6),
    ),
  ];
}
