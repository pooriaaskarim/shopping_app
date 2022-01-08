import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_dto.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_dto.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class AddProductClient extends Client {
  Future<Either<Exception, ProductModel>> addProduct(ProductDTO dto) async {
    var zResponse = await dioPost(RepositoryUrls.products(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ProductModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, ImageModel>> uploadImage(ImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productImages(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ImageModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, TagModel>> addTag(TagDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productTags(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(TagModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, Response>> deleteTag(int tagID) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productTagByID(tagID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, List<TagModel>>> getTagsList() async {
    // Retrieve Users List From Server
    List<TagModel> tags = <TagModel>[];
    var zResponse = await dioGet(RepositoryUrls.productTags());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        tags.add(TagModel.fromMap(item));
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
