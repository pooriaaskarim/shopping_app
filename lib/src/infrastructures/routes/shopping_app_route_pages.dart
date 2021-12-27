import 'package:get/get.dart';
import 'package:shopping_app/src/pages/login_page/login_page.dart';
import 'package:shopping_app/src/pages/splash_screen/splash_screen.dart';

import 'shopping_app_route_names.dart';

class RoutePages {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteNames.loginPage,
      page: () => const LoginPage(),
    ),
  ];
}
