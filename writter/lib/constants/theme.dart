import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(color: cardColor),
    primarySwatch: Colors.blue,
  );
}
