abstract class UserModel {
  int id, imageID;
  String name, surname, username, password, address;
  bool isAdmin;

  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageID,
      required this.isAdmin});

  @override
  String toString() {
    return '''UserModel{
    id: $id,
    imageID: $imageID,
    name: $name,
    surname: $surname,
    username: $username,
    password: $password,
    address: $address,
    isAdmin: $isAdmin}''';
  }
}
