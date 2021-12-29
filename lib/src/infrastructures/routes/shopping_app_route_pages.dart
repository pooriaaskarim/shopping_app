import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/views/add_product_page.dart';
import 'package:shopping_app/src/pages/admin/products_page/views/products_page.dart';
import 'package:shopping_app/src/pages/splash_screen/splash_screen.dart';
import 'package:shopping_app/src/pages/user_management/login_page/views/login_page.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/views/signup_page.dart';

import 'shopping_app_route_names.dart';

class RoutePages {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteNames.signupPage,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: RouteNames.adminProducts,
      page: () => AdminProductsPage(),
    ),
    GetPage(
      name: RouteNames.adminProduct,
      page: () => AdminProductsPage(),
    ),
    GetPage(
      name: RouteNames.adminAddProduct,
      page: () => AdminAddProductPage(),
    ),
  ];
}
