import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor:  Colors.green[600],
    primarySwatch: Colors.green,
    primaryColorDark:  Colors.grey[800],
    primaryColorLight:  Colors.green[300],
    scaffoldBackgroundColor: Colors.white,
    backgroundColor:  Colors.grey[300],

    fontFamily: 'Futura',

    textTheme:  const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    )
  );
}