import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_dto.dart';

import '../models/signup_user_model.dart';

class SignUpClient extends Client {
  Future<List<SignUpUserModel>> getUsersList() async {
    // Retrieve Users List From Server
    List<SignUpUserModel> users = <SignUpUserModel>[];
    var zResponse = await dioGet('http://$baseUrl/users');
    zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        users.add(SignUpUserModel.fromJsonMap(item));
      }
    });
    return users;
  }

  Future<Either<Exception, Response>> signUserUp(SignUpUserDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost('http://$baseUrl/users', dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, //TO-Do: Handle Error
        (response) {
      return Right(response);
    });
  }
}

// void main() async {
//   var client = SignUpClient();
//   var users = await client.getUsernamesList();
//   print(users);
// }
