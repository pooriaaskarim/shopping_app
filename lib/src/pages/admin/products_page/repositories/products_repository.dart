import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_image_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

import '../models/products_model.dart';

class AdminProductsClient extends Client {
  Future<Either<Exception, AdminUser>> getUser(int id) async {
    var zResponse = await dioGet(RepositoryUrls.userById(id));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminUser.fromJsonMap(response.data[0]));
    });
  }

  Future<Either<Exception, UserImageModel>> getUserImage(int imageID) async {
    var zResponse = await dioGet(RepositoryUrls.userImageById(imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(UserImageModel.fromMap(response.data[0]));
    });
  }

  Future<Either<Exception, List<AdminProductModel>>> getProductsList() async {
    // Retrieve Users List From Server
    List<AdminProductModel> products = <AdminProductModel>[];
    var zResponse = await dioGet(RepositoryUrls.products());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        products.add(AdminProductModel.fromMap(item));
      }
      return Right(products);
    });
  }
}

// void main() async {
//   var client = SignUpClient();
//   await client.getUsersList('http://127.0.0.1:3000/users');
//   print(client.users);
// }
