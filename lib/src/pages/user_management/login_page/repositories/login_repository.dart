import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';
import 'package:shopping_app/src/pages/user_management/login_page/models/login_user_model.dart';

class LoginClient extends Client {
  Future<Either<Exception, List<LoginUserModel>>> getUsersList() async {
    // Retrieve Users List From Server
    List<LoginUserModel> users = <LoginUserModel>[];
    var zResponse = await dioGet('http://$baseUrl/users');
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (Map<String, dynamic> item in response.data) {
        users.add(LoginUserModel.fromJsonMap(item));
      }
      return Right(users);
    });
  }
}
