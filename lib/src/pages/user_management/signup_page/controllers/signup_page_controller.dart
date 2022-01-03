import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_dto.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_model.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/user_image_dto.dart';
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
    Either<Exception, List<SignUpUserModel>> zResponse =
        await client.getUsersList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future<int> uploadImage() async {
    UserImageDTO dto = UserImageDTO(
        image: userImageHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, dio.Response> zResponse = await client.uploadImage(dto);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
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
    var dto = SignUpUserDTO(
        name: nameController.text,
        surname: surnameController.text,
        username: usernameController.text,
        password: passwordController.text,
        address: addressController.text,
        imageId: _imageID,
        isAdmin: _isAdmin);
    Either<Exception, dio.Response> zResponse = await client.signUserUp(dto);
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
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
      return 'Field can not be empty';
    }
    return null;
  }

  //List used to check if entered username is already taken
  final List<SignUpUserModel> users = [];

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
    users.addAll(await getUsers());
    super.onInit();
  }
}
