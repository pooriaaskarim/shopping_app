import 'package:dartz/dartz.dart';
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
  RxBool keepSignedIn = false.obs; //TODO: session management
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final client = LoginClient();

//TODO: Clean[your]Code
  login() async {
    Either<Exception, List<LoginUserModel>> zResponse =
        await client.getUsersList();
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Connection Error'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                login();
              })));
      throw Exception(exception);
    }, (users) {
      if (users
          .map((e) => e.username)
          .toList()
          .contains(usernameController.text)) {
        LoginUserModel user = users
            .where((element) => element.username == usernameController.text)
            .toList()[0];
        if (user.password == passwordController.text) {
          if (user.isAdmin) {
            Get.offAndToNamed(RouteNames.adminProducts,
                parameters: {'id': '${user.id}'});
          }
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Wrong username/password. Try again.')));
          passwordController.clear();
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Wrong username/password. Try again.')));
        passwordController.clear();
      }
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }
}
