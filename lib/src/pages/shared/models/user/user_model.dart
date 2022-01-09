import 'package:shopping_app/src/pages/shared/models/user/cart_item_model.dart';

class UserModel {
  int id, imageID;
  String name, surname, username, password, address;
  bool isAdmin;
  List<int> favorites;
  List<CartItemModel> cart;

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
      this.cart = const <CartItemModel>[]});

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageID': imageID,
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'address': address,
      'isAdmin': isAdmin,
      'favorites': favorites,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> jsonMap) {
    List<CartItemModel> _cart = <CartItemModel>[];
    for (var item in jsonMap['cart']) {
      _cart.add(CartItemModel.fromMap(item));
    }
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
        cart: _cart);
  }
}
