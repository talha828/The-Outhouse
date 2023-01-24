import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mighty_radio/utils/Extensions/Colors.dart';
import 'package:mighty_radio/utils/Extensions/decorations.dart';
import 'package:mighty_radio/utils/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: scaffoldColor,
      primaryColor: primaryColor1,
      iconTheme: IconThemeData(color: Colors.black),
      fontFamily: GoogleFonts.poppins().fontFamily,
      dividerColor: viewLineColor,
      colorScheme: ColorScheme(
        primary: primaryColor1,
        secondary: secondaryColor,
        surface: Colors.white,
        background: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.redAccent,
        brightness: Brightness.light,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: radius(20), side: BorderSide(width: 1)),
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(primaryColor1),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ));

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldColorDark,
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme(
      primary: primaryColor1,
      secondary: secondaryColor,
      surface: Colors.black,
      background: Colors.black,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.redAccent,
      brightness: Brightness.dark,
    ),
    dividerColor: Colors.white24,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
