import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Colors.blue,
  highlightColor: Colors.red,
  //buttonColor: Colors.yellow,
  scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
  buttonTheme: const ButtonThemeData(
      buttonColor: Colors.green, textTheme: ButtonTextTheme.primary),
  fontFamily: 'Bebas',
  textTheme: const TextTheme(
    button: TextStyle(fontSize: 18),
    subtitle1: TextStyle(fontSize: 18),
    headline1: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 40,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Colors.white),
);

const primaryColor = Color(0xFFFA8035);
const SecondaryColor = Color(0xFFFBA421);
const backgroudColor = Color(0xFFEA973E);
const bgColor = Colors.white10;
const buttonColor = Color(0xFF00B0D7);
const textFiled = Color(0xFF707276);

const defaultPadding = 20.0;
