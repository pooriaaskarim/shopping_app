class UserModel {
  int id, imageID;
  String name, surname, username, password, address;
  bool isAdmin;
  List favorites, cart;

  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageID,
      required this.isAdmin,
      this.favorites = const <int>[],
      this.cart = const <int>[]});

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
    isAdmin: $isAdmin,
    favorites: $favorites,
    cart: $cart}''';
  }

  factory UserModel.fromMap(Map<String, dynamic> jsonMap) {
    return UserModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        surname: jsonMap['surname'],
        username: jsonMap['username'],
        password: jsonMap['password'],
        address: jsonMap['address'],
        imageID: jsonMap['imageID'],
        isAdmin: jsonMap['isAdmin'],
        favorites: jsonMap['favorites'].cast<int>(),
        cart: jsonMap['cart'].cast<int>());
  }
}
