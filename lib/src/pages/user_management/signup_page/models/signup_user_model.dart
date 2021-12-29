import 'package:shopping_app/src/pages/user_management/shared/models/user_model.dart';

class SignUpUserModel extends UserModel {
  SignUpUserModel(int id, String name, String surname, String username,
      String password, String address, {required bool isAdmin})
      : super(
            id: id,
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            isAdmin: false);

  SignUpUserModel.fromJsonMap(Map<String, dynamic> jsonMap)
      : super(
            id: jsonMap['id'],
            name: jsonMap['name'],
            surname: jsonMap['surname'],
            username: jsonMap['username'],
            password: jsonMap['password'],
            address: jsonMap['address'],
            isAdmin: jsonMap['isAdmin']);

// @override
// String toString() {
//   return '''
//   UserModel{
//     ID: $id,
//     Name: $name,
//     Surname: $surname,
//     Username: $username,
//     Password: $password,
//     Address: $address,
//     Is Admin: $isAdmin}''';
// }
}
