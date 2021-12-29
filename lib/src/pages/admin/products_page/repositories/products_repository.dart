import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

import '../models/products_model.dart';

class AdminProductsClient extends Client {
  Future<List<ProductModel>> getProductsList(String url) async {
    // Retrieve Users List From Server
    List<ProductModel> users = <ProductModel>[];
    var zResponse = await dioGet(url);
    zResponse.fold((exception) => throw exception, (response) {
      for (var item in response.data) {
        users.add(ProductModel.fromMap(item));
      }
    });
    return users;
  }
}

// void main() async {
//   var client = SignUpClient();
//   await client.getUsersList('http://127.0.0.1:3000/users');
//   print(client.users);
// }
