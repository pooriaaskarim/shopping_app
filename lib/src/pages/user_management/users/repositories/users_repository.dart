import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';
import 'package:shopping_app/src/pages/user_management/users/models/users_model.dart';

class UsersClient extends Client {
  Future<Either<Exception, UsersModel>> getUsers() async {
    // Retrieve Users List From Server
    UsersModel users = UsersModel([]);
    var zResponse = await dioGet(RepositoryUrls.users());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (Map<String, dynamic> item in response.data) {
        users.addFromJsonMap(item);
      }
      return Right(users);
    });
  }
}
