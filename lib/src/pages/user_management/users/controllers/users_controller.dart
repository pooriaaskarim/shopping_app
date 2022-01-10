import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/user_management/users/repositories/users_repository.dart';

class UsersController extends GetxController {
  RxList<UserModel> users = RxList<UserModel>();
  final client = UsersClient();
  Future getUsers() async {
    Either<Exception, List<UserModel>> zResponse = await client.getUsers();
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
      throw Exception(exception);
    }, (usersObject) {
      users.value = usersObject;
    });
  }

  @override
  void refresh() async {
    getUsers();
    super.refresh();
  }

  @override
  void onInit() async {
    getUsers();
    super.onInit();
  }
}
