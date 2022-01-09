import 'package:shopping_app/src/pages/shared/models/user/cart_item_model.dart';

class UserDTO {
  String name, surname, username, password, address;
  int imageID;
  bool isAdmin;
  List favorites;
  List<CartItemModel> cart;

  UserDTO(
      {required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.address,
      required this.imageID,
      this.isAdmin = false,
      this.favorites = const <int>[],
      this.cart = const <CartItemModel>[]});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'address': address,
      'imageID': imageID,
      'isAdmin': isAdmin,
      'favorites': favorites,
      'cart': cart
    };
  }
}
