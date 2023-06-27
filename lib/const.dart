import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class Const {
  static const apiUrl = "https://superheroapi.com/api/10167700845705177";

  static final powerstatColors = <String, Color>{
    'intelligence': CColors.mainColor,
    'strength': Colors.red,
    'speed': CColors.textColor,
    'durability': Colors.teal,
    'power': Colors.amber,
    'combat': Colors.green,
  };
}
