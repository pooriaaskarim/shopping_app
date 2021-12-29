import 'package:flutter/material.dart';

class MaterialTheme {
  // late final String fontFamily;

  MaterialTheme();

  // ShoppingAppMaterialTheme({required final this.fontFamily});

  static const MaterialColor primaryColor = MaterialColor(0xffFF9F4A, {
    50: Color(0xffFFF2E9), //Primary Light
    100: Color(0xffffe0ca),
    200: Color(0xffffd7b8),
    300: Color(0xffFFBE8E), //Primary Pale
    400: Color(0xffff9446),
    500: Color(0xffFA6A00), //Primary Shiny
    600: Color(0xffdc5e00),
    700: Color(0xffc25200), //Primary Dark
    800: Color(0xff973f00),
    900: Color(0xff271000),
  });
  static const MaterialColor secondaryColor = MaterialColor(0xff2E9E92, {
    50: Color(0xffC0D3D1), //Complementary Light
    100: Color(0xff95bab6),
    200: Color(0xff79b7b0),
    300: Color(0xff67B9B0), //Complementary Pale
    400: Color(0xff31b3a5),
    500: Color(0xff009c8b), //Complementary Shiny
    600: Color(0xff179083),
    700: Color(0xff00786C), //Complementary Dark
    800: Color(0xff004b43),
    900: Color(0xff002f2b),
  });
  static const Color infoColor = Color(0xff67B9B0);
  static const Color backgroundColor = Color(0xffFFF2E9);
  static const Color textColor = Color(0xff271000);
  static const Color editingColor = Color(0xffc25200);
  static const Color iconColor = Color(0xffc25200);
  static const Color disabledColor = Color(0xff707070);

  // static const Color warningColor = Color(0xFFF97662);
  // static const Color liteTextColor = Color(0xFFF2E9E4);
  // static const Color borderColor = Color(0xffc25200);
  // static const Color successColor = Color(0xFF57B894);
  // static const Color dangerColor = Color(0xFFD1495B);

  ThemeData get themeData => ThemeData(
        appBarTheme: appBarTheme(),
        backgroundColor: backgroundColor,
        bottomAppBarColor: const Color(0xffffffff),
        canvasColor: backgroundColor,
        cardColor: const Color(0x4dc0d3d1),
        dividerColor: const Color(0xffc25200),
        disabledColor: disabledColor,
        elevatedButtonTheme: elevatedButtonThemeData(),
        indicatorColor: const Color(0xffc25200),
        inputDecorationTheme: inputDecorationTheme(),
        secondaryHeaderColor: const Color(0xffe3f2fd),
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: textTheme(),

        // hintColor: const Color(0x8a000000),
        // fontFamily: fontFamily,
        // brightness: Brightness.dark,
        // primaryColor: primaryColor,
        // primaryColorBrightness: Brightness.light,
        // primaryColorLight: primaryColor[200],
        // primaryColorDark: primaryColor[900],
        // highlightColor: const Color(0x66bcbcbc),
        // splashColor: const Color(0x66c8c8c8),
        // selectedRowColor: const Color(0xfff5f5f5),
        // unselectedWidgetColor: const Color(0x8a000000),
        // buttonColor: const Color(0xffe0e0e0),
        // toggleableActiveColor: const Color(0xff1e88e5),
        // dialogBackgroundColor: backgroundColor,
      );

  ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xffFF9F4A)),
            fixedSize: MaterialStateProperty.all(const Size.fromHeight(48)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ))));
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Color(0xffc25200), size: 24),
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
        labelStyle: const TextStyle(color: MaterialTheme.textColor),
        suffixIconColor: MaterialTheme.primaryColor[700],
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: MaterialTheme.editingColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: MaterialTheme.editingColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MaterialTheme.editingColor),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: MaterialTheme.editingColor)),
        disabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: MaterialTheme.disabledColor)));
  }

  TextTheme textTheme() {
    return TextTheme(
      headline1: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline2: const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      headline3: TextStyle(
          color: primaryColor[50], fontSize: 34.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: primaryColor[50], fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyText1: const TextStyle(fontSize: 14.0, color: editingColor),
      bodyText2: const TextStyle(fontSize: 14.0, color: textColor),
      // subtitle1: TextStyle(),
      // subtitle2: TextStyle(),
      // caption: TextStyle(),
      // button: TextStyle(),
      // overline: TextStyle(),
    );
  }
}
