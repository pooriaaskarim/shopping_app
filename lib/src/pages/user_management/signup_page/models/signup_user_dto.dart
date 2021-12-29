import 'package:shopping_app/src/pages/user_management/shared/models/user_dto.dart';

class SignUpUserDTO extends UserDTO {
  SignUpUserDTO(String name, String surname, String username, String password,
      String address, {required bool isAdmin})
      : super(
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            isAdmin: false);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'address': address,
      'isAdmin': isAdmin
    };
  }
}
