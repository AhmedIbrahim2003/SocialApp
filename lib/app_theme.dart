import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  ),
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 16,
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey),
);
