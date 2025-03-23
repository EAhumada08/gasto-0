import 'package:flutter/material.dart';
import 'package:gasto_0/core/const.dart';

ThemeData mainTheme = ThemeData(
  primaryColor: primaryColor,
  primaryTextTheme: TextTheme(
    labelMedium: TextStyle(
        fontSize: 24.0, color: primaryColor, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, color: primaryColor),
    titleMedium: TextStyle(fontSize: 28.0, color: Colors.black),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
  ),
  useMaterial3: true,
);
