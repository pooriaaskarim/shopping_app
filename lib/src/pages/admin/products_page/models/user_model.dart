import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';

class AdminUser extends UserModel {
  AdminUser(
      {required int id,
      required String name,
      required String surname,
      required String username,
      required String password,
      required String address,
      required int imageId,
      required bool isAdmin})
      : super(
            id: id,
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            imageId: imageId,
            isAdmin: isAdmin);

  AdminUser.fromJsonMap(Map<String, dynamic> jsonMap)
      : super(
            id: jsonMap['id'],
            name: jsonMap['name'],
            surname: jsonMap['surname'],
            username: jsonMap['username'],
            password: jsonMap['password'],
            address: jsonMap['address'],
            imageId: jsonMap['imageId'],
            isAdmin: jsonMap['isAdmin']);
}
