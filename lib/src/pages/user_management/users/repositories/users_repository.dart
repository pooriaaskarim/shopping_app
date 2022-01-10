import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class UsersClient extends Client {
  Future<Either<Exception, List<UserModel>>> getUsers() async {
    // Retrieve Users List From Server
    List<UserModel> users = [];
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
}
