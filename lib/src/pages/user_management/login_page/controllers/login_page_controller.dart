import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/user_management/login_page/repositories/login_repository.dart';

class LoginController extends GetxController {
  final RxList<Map<String, dynamic>> passwordIsVisible = [
    {'value': true, 'icon': const Icon(Icons.visibility_off)},
    {'value': false, 'icon': const Icon(Icons.visibility)}
  ].obs;
  // RxBool keepSignedIn = false.obs; //TODO: session management
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final client = LoginClient();

  login() async {
    Either<Exception, List<UserModel>> zResponse = await client.getUsersList();
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_connection_error.tr),
          action: SnackBarAction(
              label: LocaleKeys.error_data_retry.tr,
              onPressed: () {
                login();
              })));
      throw Exception(exception);
    }, (users) {
      if (users
          .map((e) => e.username)
          .toList()
          .contains(usernameController.text)) {
        UserModel user = users
            .where((element) => element.username == usernameController.text)
            .toList()[0];
        if (user.password == passwordController.text) {
          if (user.isAdmin) {
            Get.offAndToNamed(RouteNames.adminProducts,
                parameters: {'id': '${user.id}'});
          }
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content:
                  Text(LocaleKeys.error_data_wrong_credentials_try_again.tr)));
          passwordController.clear();
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content:
                Text(LocaleKeys.error_data_wrong_credentials_try_again.tr)));
        passwordController.clear();
      }
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    }
    return null;
  }
}
