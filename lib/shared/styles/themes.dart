import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(
  primarySwatch:defaultColor,
  scaffoldBackgroundColor:   HexColor('333739'),
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      titleSpacing: 20.0,

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:  HexColor('333739'),
        statusBarIconBrightness: Brightness.light,

      ),
      backgroundColor:   HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: TextStyle(

        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,

      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      )

  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor ,

    elevation: 20.0,
    backgroundColor:  HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),


  ),
  fontFamily: 'jannah',



);
ThemeData lightTheme=ThemeData(
  primarySwatch:defaultColor,
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),
  scaffoldBackgroundColor:  Colors.white,
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      titleSpacing: 20.0,

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,

      ),
      backgroundColor:  Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(

        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,

      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      )

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,

    elevation: 20.0,
    backgroundColor:  Colors.white,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )

  ),
  fontFamily: 'jannah',
);