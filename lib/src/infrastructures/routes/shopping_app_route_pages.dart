import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/commons/add_product_bindings.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/views/add_product_page.dart';
import 'package:shopping_app/src/pages/admin/product_page/commons/product_bindings.dart';
import 'package:shopping_app/src/pages/admin/product_page/views/product_page.dart';
import 'package:shopping_app/src/pages/admin/products_page/commons/products_bindings.dart';
import 'package:shopping_app/src/pages/admin/products_page/views/products_page.dart';
import 'package:shopping_app/src/pages/search/commons/search_bindings.dart';
import 'package:shopping_app/src/pages/search/views/search_page.dart';
import 'package:shopping_app/src/pages/splash_screen/splash_screen.dart';
import 'package:shopping_app/src/pages/user_management/login_page/commons/login_bindings.dart';
import 'package:shopping_app/src/pages/user_management/login_page/views/login_page.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/commons/signup_bindings.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/views/signup_page.dart';
import 'package:shopping_app/src/pages/user_management/users/commons/users_bindings.dart';
import 'package:shopping_app/src/pages/user_management/users/views/users_page.dart';

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
        binding: LoginBindings()),
    GetPage(
      name: RouteNames.signupPage,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: RouteNames.adminProducts,
      page: () => AdminProductsPage(),
      binding: AdminProductsBinding(),
    ),
    GetPage(
      name: RouteNames.adminProduct,
      page: () => AdminProductPage(),
      binding: AdminProductBinding(),
    ),
    GetPage(
      name: RouteNames.adminAddProduct,
      page: () => AdminAddProductPage(),
      binding: AdminAddProductBinding(),
    ),
    GetPage(
      name: RouteNames.usersPage,
      page: () => UsersPage(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: RouteNames.searchPage,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
  ];
}
