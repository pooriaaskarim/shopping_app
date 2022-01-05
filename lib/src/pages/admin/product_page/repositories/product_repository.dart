import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_image_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class AddProductClient extends Client {
  Future<Either<Exception, Response>> addProduct(AdminAddProductDTO dto) async {
    var zResponse = await dioPost(RepositoryUrls.products(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> uploadImage(
      AdminAddProductImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productImages(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> addTag(AdminAddProductTagDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productTags(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> deleteTag(int id) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productById(id));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, List<AdminAddProductTagModel>>> getTagsList() async {
    // Retrieve Users List From Server
    List<AdminAddProductTagModel> tags = <AdminAddProductTagModel>[];
    var zResponse = await dioGet(RepositoryUrls.products());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        tags.add(AdminAddProductTagModel.fromMap(item));
      }
      return Right(tags);
    });
  }
}

// void main() async {
//   var client = SignUpClient();
//   await client.getUsersList('http://127.0.0.1:3000/users');
//   print(client.users);
// }