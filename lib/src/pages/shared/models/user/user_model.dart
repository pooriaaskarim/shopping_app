abstract class UserModel {
  int id, imageId;
  String name, surname, username, password, address;
  bool isAdmin;

  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageId,
      required this.isAdmin});
}
