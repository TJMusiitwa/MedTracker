import 'package:flutter/material.dart';

final ThemeData medTrackerTheme = ThemeData(
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: Color.fromRGBO(249, 97, 107, 1),
  accentColorBrightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cursorColor: Color(0xffff9499),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0x61000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: false,
    contentPadding:
        EdgeInsets.only(top: 24.0, bottom: 16.0, left: 12.0, right: 12.0),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color(0x00000000),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
    border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4.0),
  ),
);
