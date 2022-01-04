import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';

class LoginUserModel extends UserModel {
  LoginUserModel(
      {required int id,
      required String name,
      required String surname,
      required String username,
      required String password,
      required String address,
      required int imageID,
      required bool isAdmin})
      : super(
            id: id,
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            imageID: imageID,
            isAdmin: isAdmin);

  LoginUserModel.fromJsonMap(Map<String, dynamic> jsonMap)
      : super(
            id: jsonMap['id'],
            name: jsonMap['name'],
            surname: jsonMap['surname'],
            username: jsonMap['username'],
            password: jsonMap['password'],
            address: jsonMap['address'],
            imageID: jsonMap['imageID'],
            isAdmin: jsonMap['isAdmin']);
}
