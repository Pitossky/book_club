import 'package:flutter/material.dart';

class AppTheme{
  final Color _lightGreen = const Color.fromARGB(255, 213, 235, 220);
  final Color _lightGrey = const Color.fromARGB(255, 164, 164, 164);
  final Color _darkerGrey = const Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _lightGreen,
      primaryColor: _lightGreen,
      hintColor: _lightGrey,
      secondaryHeaderColor: _darkerGrey,
     inputDecorationTheme: InputDecorationTheme(
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20),
         borderSide: BorderSide(color: _lightGrey),
       ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20),
         borderSide: BorderSide(color: _lightGreen),
       )
     ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkerGrey,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      )
    );
  }
}