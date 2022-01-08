import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_dto.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/repositories/signup_repository.dart';

class SignUpController extends GetxController {
  //list used to handle password field visibility
  final RxList<Map<String, dynamic>> passwordIsVisible = [
    {'value': true, 'icon': const Icon(Icons.visibility_off)},
    {'value': false, 'icon': const Icon(Icons.visibility)}
  ].obs;
  final RxList<Map<String, dynamic>> retypePasswordIsVisible = [
    {'value': true, 'icon': const Icon(Icons.visibility_off)},
    {'value': false, 'icon': const Icon(Icons.visibility)}
  ].obs;

  final ImageHandler userImageHandler = ImageHandler();

  //text field controllers
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final addressController = TextEditingController();

  final client = SignUpClient();

  Future getUsers() async {
    Either<Exception, List<UserModel>> zResponse = await client.getUsersList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future<int> uploadImage() async {
    ImageDTO dto =
        ImageDTO(image: userImageHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, dio.Response> zResponse = await client.uploadImage(dto);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception); //TODO: handle Error
    }, (response) {
      return response.data['id'];
    });
  }

  Future signUp() async {
    int _imageID = 0;
    bool _isAdmin = false;
    if (users.isEmpty) {
      _isAdmin = true;
    }
    if (userImageHandler.imageFile.value != null) {
      _imageID = await uploadImage();
    }
    var dto = UserDTO(
        name: nameController.text,
        surname: surnameController.text,
        username: usernameController.text,
        password: passwordController.text,
        address: addressController.text,
        imageID: _imageID,
        isAdmin: _isAdmin);
    Either<Exception, dio.Response> zResponse = await client.signUserUp(dto);
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception);
    }, (response) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text('User ${response.data['username']} successfully created.')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    }
    return null;
  }

  //List used to check if entered username is already taken
  final List<UserModel> users = [];

  String? usernameValidator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    } else if (users.map((e) => e.username).toList().contains(v)) {
      return LocaleKeys.error_data_username_is_taken_error.tr;
    } else if (v.length <= 3) {
      return LocaleKeys.error_data_username_length_error.tr;
    }
    return null;
  }

  String? passwordValidator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    } else if (v.length < 8) {
      return LocaleKeys.error_data_password_length_error.tr;
    }
    return null;
  }

  String? retypePasswordValidator(String? v) {
    if (v != passwordController.text) {
      return LocaleKeys.error_data_retype_password_error.tr;
    }
    return null;
  }

  @override
  void onInit() async {
    users.addAll(await getUsers());
    super.onInit();
  }
}
