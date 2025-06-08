import 'package:flutter/material.dart';

final ThemeData customLightTheme = ThemeData(
  brightness: Brightness.light,

  primarySwatch: Colors.blue,

  scaffoldBackgroundColor: Colors.white,

  elevatedButtonTheme: ElevatedButtonThemeData(

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,          // Button background in light mode
      foregroundColor: Colors.white,          // Button text/icon color
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

    ),

  ),
);

final ThemeData customDarkTheme = ThemeData(
  brightness: Brightness.dark,

  primarySwatch: Colors.blue,

  scaffoldBackgroundColor: Colors.black,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(fontFamily: 'poppins'),
      backgroundColor: Colors.white,         
      foregroundColor: Colors.black,         
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

  ),

  appBarTheme: AppBarTheme(foregroundColor: Colors.white)
  
);
