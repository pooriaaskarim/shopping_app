import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/user_management/login_page/models/login_user_model.dart';
import 'package:shopping_app/src/pages/user_management/login_page/repositories/login_repository.dart';

class LoginController extends GetxController {
  final RxList<Map<String, dynamic>> passwordIsVisible = [
    {'value': true, 'icon': const Icon(Icons.visibility_off)},
    {'value': false, 'icon': const Icon(Icons.visibility)}
  ].obs;
  RxBool keepSignedIn = false.obs;
  final List<LoginUserModel> users = [];
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final client = LoginClient();

  void login() {
    if (users
        .map((e) => e.username)
        .toList()
        .contains(usernameController.text)) {
      // print('User available');
      LoginUserModel user = users
          .where((element) => element.username == usernameController.text)
          .toList()[0];
      if (user.password == passwordController.text) {
        if (user.isAdmin) {
          Get.offAndToNamed(RouteNames.adminProducts);
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Wrong username/password. Try again.')));
        passwordController.clear();
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Wrong username/password. Try again.')));
      passwordController.clear();
    }
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }

  @override
  void onInit() async {
    users.addAll(await client.getUsersList());
    super.onInit();
  }
}
