import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  ShoppingApp({final Key? key}) : super(key: key);
  // String baseUrl = '127.0.0.1:3000';
  String baseUrl = '10.0.2.2:3000';

  void _setInitialUrlData() {
    ShoppingAppParameters.fullBaseUrl = 'http://$baseUrl';
  }

  @override
  Widget build(final BuildContext context) {
    _setInitialUrlData();
    return GetMaterialApp(
      title: 'Shopping App',
      theme: MaterialTheme().themeData,
      getPages: [...ShoppingAppParameters.pages],
      initialRoute: RouteNames.splashScreen,
    );
  }
}
