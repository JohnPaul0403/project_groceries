import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColors {
  static Color red = Color(0xffFF0100);
  static Color blue = Color.fromARGB(255, 0, 157, 164);
  static Color SecondaryBlue = Color.fromARGB(255, 0, 142, 151);
  static Color activeBlue = CupertinoColors.activeBlue;
  static Color green = Color.fromARGB(255, 57, 255, 20);
  static Color secondaryGreen = Color(0xff9EC00C);
  static Color black = Colors.black;
  static Color darkModeBlack = Color.fromARGB(255, 41, 41, 41);
  static MaterialColor gray = Colors.blueGrey;
  static Color navBarGray = Color.fromARGB(255, 220, 220, 220);
  static Color white = CupertinoColors.white;
  static Color inactiveWhite = Color.fromARGB(255, 244, 244, 244);
  static Color orange = Colors.orangeAccent;

  static bool _darkMode = false;

  static darkMode() {
    return _darkMode;
  }
}