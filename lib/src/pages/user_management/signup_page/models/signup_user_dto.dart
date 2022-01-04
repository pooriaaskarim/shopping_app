import 'package:shopping_app/src/pages/shared/models/user/user_dto.dart';

class SignUpUserDTO extends UserDTO {
  SignUpUserDTO({
    required String name,
    required String surname,
    required String username,
    required String password,
    required String address,
    required int imageID,
    required bool isAdmin,
  }) : super(
            name: name,
            surname: surname,
            username: username,
            password: password,
            address: address,
            imageID: imageID,
            isAdmin: isAdmin);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'address': address,
      'imageID': imageID,
      'isAdmin': isAdmin
    };
  }
}
