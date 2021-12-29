abstract class UserDTO {
  String name, surname, username, password, address;
  bool isAdmin;
  UserDTO(
      {required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      this.isAdmin = false});
}
