class UserDTO {
  String name, surname, username, password, address;
  int imageID;
  bool isAdmin;

  UserDTO(
      {required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageID,
      this.isAdmin = false});
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
