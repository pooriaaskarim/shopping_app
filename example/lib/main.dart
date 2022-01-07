import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({final Key? key}) : super(key: key);
  // String baseUrl = '127.0.0.1:3000';
  final String baseUrl = '10.0.2.2:3000';

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
      //localization
      translations: LocalizationService(),
      translationsKeys: AppTranslation.translations,
      locale: const Locale('fa', 'IR'),
    );
  }
}

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'fa_Ir': Locales.fa_IR, 'en_Us': Locales.en_US};
}
