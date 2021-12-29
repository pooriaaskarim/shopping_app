import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_dto.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_model.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/repositories/signup_repository.dart';

class SignUpController extends GetxController {
  final RxList<Map<String, dynamic>> passwordIsVisible = [
    {'value': true, 'icon': const Icon(Icons.visibility_off)},
    {'value': false, 'icon': const Icon(Icons.visibility)}
  ].obs;
  final List<SignUpUserModel> users = [];
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final addressController = TextEditingController();
  final client = SignUpClient();

  Future signUp() async {
    bool _isAdmin = false;
    if (users.isEmpty) {
      _isAdmin = true;
    }
    var dto = SignUpUserDTO(
        nameController.text,
        surnameController.text,
        usernameController.text,
        passwordController.text,
        addressController.text,
        isAdmin: _isAdmin);
    final Either<Exception, dio.Response> zResponse =
        await client.signUserUp(dto);
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
    }, (response) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text('User ${usernameController.text} successfully created.')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }

  String? usernameValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    } else if (users.map((e) => e.username).toList().contains(v)) {
      return 'Username is taken';
    } else if (v.length <= 3) {
      return 'Username must be at least 4 characters';
    }
    return null;
  }

  String? passwordValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    } else if (v.length < 8) {
      return 'Password must be 8 characters or longer';
    }
    return null;
  }

  String? retypePasswordValidator(String? v) {
    if (v != passwordController.text) {
      return 'Check your password and try again';
    }
    return null;
  }

  @override
  void onInit() async {
    users.addAll(await client.getUsersList());
    super.onInit();
  }
}
