import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({final Key? key}) : super(key: key);
  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping App',
      theme: MaterialTheme().themeData,
      getPages: [...ShoppingAppParameters.pages],
      initialRoute: RouteNames.splashScreen,
    );
  }
}
