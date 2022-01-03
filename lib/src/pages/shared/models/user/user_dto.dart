abstract class UserDTO {
  String name, surname, username, password, address;
  int imageId;
  bool isAdmin;

  UserDTO(
      {required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageId,
      this.isAdmin = false});
}