import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_dto.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class SignUpClient extends Client {
  Future<Either<Exception, List<UserModel>>> getUsersList() async {
    // Retrieve Users List From Server
    List<UserModel> users = <UserModel>[];
    var zResponse = await dioGet(RepositoryUrls.users());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (Map<String, dynamic> item in response.data) {
        users.add(UserModel.fromMap(item));
      }
      return Right(users);
    });
  }

  Future<Either<Exception, Response>> signUserUp(UserDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.users(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> uploadImage(ImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.userImages(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }
}
