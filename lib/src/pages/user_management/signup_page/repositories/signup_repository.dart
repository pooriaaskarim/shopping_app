import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/signup_user_dto.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/models/user_image_dto.dart';

import '../models/signup_user_model.dart';

class SignUpClient extends Client {
  Future<Either<Exception, List<SignUpUserModel>>> getUsersList() async {
    // Retrieve Users List From Server
    List<SignUpUserModel> users = <SignUpUserModel>[];
    var zResponse = await dioGet('http://$baseUrl/users');
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (Map<String, dynamic> item in response.data) {
        users.add(SignUpUserModel.fromJsonMap(item));
      }
      return Right(users);
    });
  }

  Future<Either<Exception, Response>> signUserUp(SignUpUserDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost('http://$baseUrl/users', dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> uploadImage(UserImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost('http://$baseUrl/user_images', dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }
}

// void main() async {
//   var client = SignUpClient();
//   var users = await client.getUsernamesList();
//   print(users);
// }
