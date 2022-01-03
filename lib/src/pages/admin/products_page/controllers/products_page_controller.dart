import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/products_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_image_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/repositories/products_repository.dart';

class AdminProductsController extends GetxController {
  int id = 0;
  Rxn<UserImageModel> userImage = Rxn<UserImageModel>();
  Rxn<AdminUser> user = Rxn<AdminUser>();
  final client = AdminProductsClient();

  Future getUser(id) async {
    Either<Exception, AdminUser> zResponse = await client.getUser(id);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle error
    }, (userModel) {
      return userModel;
    });
  }

  Future<UserImageModel> getUserImage(int imageID) async {
    Either<Exception, UserImageModel> zResponse =
        await client.getUserImage(imageID);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle error
    }, (imageModel) {
      return imageModel;
    });
  }

  Future<List<AdminProductModel>> getProductsList() async {
    Either<Exception, List<AdminProductModel>> zResponse =
        await client.getProductsList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, //TODO: handle error
        (response) {
      return response;
    });
  }

  @override
  void onInit() async {
    id = int.parse(Get.parameters['id']!);
    if (id != 0) {
      user.value = await getUser(id); //TODO: handle client error
      userImage.value = await getUserImage(user.value!.imageId);
    }
    super.onInit();
  }
}
