import 'package:flutter/material.dart';

class CustomMaterialTheme {
  late final String fontFamily;

  CustomMaterialTheme({required final this.fontFamily});

  static const MaterialColor primaryColor = MaterialColor(0xffFF9F4A, {
    50: Color(0xffFFF2E9), //Primary Light
    100: Color(0xffFFBE8E), //Primary Pale
    200: Color(0xffFA6A00), //Primary Shiny
    300: Color(0xffc25200), //Primary Dark
  });
  static const MaterialColor secondaryColor = MaterialColor(0xff2E9E92, {
    50: Color(0xffC0D3D1), //Complementary Light
    100: Color(0xff67B9B0), //Complementary Pale
    200: Color(0xff009C8B), //Complementary Shiny
    300: Color(0xff00786C), //Complementary Dark
  });
  static const Color infoColor = Color(0xff67B9B0);
  static const Color backgroundColor = Color(0xffFFF2E9);
  static const Color textColor = Color(0xff000000);
  static const Color editingTextColor = Color(0xffc25200);
  static const Color liteTextColor = Color(0xFFF2E9E4);
  // static const Color borderColor = Color(0xffc25200);
  static const Color iconColor = Color(0xffc25200);
  // static const Color successColor = Color(0xFF57B894);
  // static const Color dangerColor = Color(0xFFD1495B);
  static const Color warningColor = Color(0xFFF97662);
  static const Color disabledColor = Color(0x4D707070);

  ThemeData get themeData => ThemeData(
        fontFamily: fontFamily,
        primarySwatch: primaryColor,
        // brightness: Brightness.dark,
        // primaryColor: primaryColor,
        // primaryColorBrightness: Brightness.light,
        // primaryColorLight: primaryColor[200],
        // primaryColorDark: primaryColor[900],
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: Color(0x00000000),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xffc25200), size: 24),
        ),
        bottomAppBarColor: const Color(0xffffffff),
        cardColor: const Color(0x4dc0d3d1),
        dividerColor: const Color(0xffc25200),
        // highlightColor: const Color(0x66bcbcbc),
        // splashColor: const Color(0x66c8c8c8),
        // selectedRowColor: const Color(0xfff5f5f5),
        // unselectedWidgetColor: const Color(0x8a000000),
        disabledColor: disabledColor,
        // buttonColor: const Color(0xffe0e0e0),
        // toggleableActiveColor: const Color(0xff1e88e5),
        secondaryHeaderColor: const Color(0xffe3f2fd),
        backgroundColor: backgroundColor,
        // dialogBackgroundColor: backgroundColor,
        indicatorColor: const Color(0xffc25200),
        // hintColor: const Color(0x8a000000),
      );
}
