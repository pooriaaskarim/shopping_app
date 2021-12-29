import 'package:shopping_app/src/pages/user_management/shared/models/user_model.dart';

class LoginUserModel extends UserModel {
  LoginUserModel(int id, String name, String surname, String username,
      String password, String address, {required bool isAdmin})
      : super(
            id: id,
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            isAdmin: false);

  LoginUserModel.fromJsonMap(Map<String, dynamic> jsonMap)
      : super(
            id: jsonMap['id'],
            name: jsonMap['name'],
            surname: jsonMap['surname'],
            username: jsonMap['username'],
            password: jsonMap['password'],
            address: jsonMap['address'],
            isAdmin: jsonMap['isAdmin']);
}
