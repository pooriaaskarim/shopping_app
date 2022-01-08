import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/admin/product_page/repositories/product_repository.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_dto.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';

class AdminProductController extends GetxController {
  final client = AdminProductClient();
  int productID = 0;
  RxBool editingMode = false.obs;
  RxBool isEnabled = false.obs;
  Rxn<ProductModel> product = Rxn<ProductModel>();
  Rxn<ImageModel> productImage = Rxn<ImageModel>();
  RxList<TagModel> tags = <TagModel>[].obs;
  RxSet<String> productTags = <String>{}.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  ImageHandler productImagerHandler = ImageHandler();

  Future<ProductModel> getProduct(int productID) async {
    Either<Exception, ProductModel> zResponse =
        await client.getProduct(productID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t retrieve product.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                getProduct(productID);
              })));
      const Text('Unable to load page');
      throw Exception(exception);
    }, (productModel) {
      return productModel;
    });
  }

  Future<ImageModel> getProductImage(int imageID) async {
    Either<Exception, ImageModel> zResponse =
        await client.getProductImage(imageID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t retrieve product.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                getProductImage(imageID);
              })));
      const Text('Unable to load page');
      throw Exception(exception);
    }, (productImageModel) {
      return productImageModel;
    });
  }

  Future initProduct(int productID) async {
    product.value = await getProduct(productID);
    productImage.value = await getProductImage(product.value!.imageID);
  }

  void initForm() {
    nameController.text = product.value!.name;
    inStockController.text = product.value!.inStock.toString();
    descriptionController.text = product.value!.description;
    priceController.text = product.value!.price;
    isEnabled.value = product.value!.isEnabled;
    productTags.addAll(product.value!.tags);
  }

  Future<ImageModel> uploadImage() async {
    ImageDTO dto = ImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, ImageModel> zResponse = await client.uploadImage(dto);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Left(
          Exception('Failed to add Image: Connection Error: $exception'));
    }, (imageModel) {
      return imageModel;
    });
  }

  Future toggleProduct() async {
    product.value!.isEnabled = isEnabled.value;
    Either<Exception, ProductModel> zResponse =
        await client.updateProduct(product.value!);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text.rich(TextSpan(children: [
          TextSpan(text: '${LocaleKeys.tr_data_product.tr} '),
          TextSpan(
              text: '${model.name} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text: model.isEnabled
                  ? LocaleKeys.tr_data_enabled.tr
                  : LocaleKeys.tr_data_disabled.tr)
        ])),
        duration: const Duration(seconds: 2),
      ));
      return model;
    });
  }

  Future updateProduct() async {
    int _imageID;
    if (productImagerHandler.imageFile.value != null) {
      ImageModel updateImageModel = await uploadImage();
      _imageID = updateImageModel.id;
    } else {
      _imageID = product.value!.imageID;
    }
    ProductModel updateModel = ProductModel(
        id: product.value!.id,
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        tags: productTags.toList(),
        inStock: int.parse(inStockController.text),
        imageID: _imageID,
        isEnabled: isEnabled.value);
    Either<Exception, ProductModel> zResponse =
        await client.updateProduct(updateModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_couldnt_update_product.tr),
          action: SnackBarAction(
              label: LocaleKeys.error_data_retry.tr,
              onPressed: () {
                updateProduct();
              })));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              '${LocaleKeys.tr_data_product.tr} ${nameController.text} ${LocaleKeys.tr_data_updated.tr}')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      return model;
    });
  }

  Future deleteProduct(ProductModel productModel) async {
    Either<Exception, dio.Response> zResponse =
        await client.deleteProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception);
    }, (response) async {
      Either<Exception, dio.Response> zResponse =
          await client.deleteProductImage(productModel);
      zResponse.fold((exception) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
        throw Exception(exception);
      }, (response) async {
        return Right(response);
      });
      return Right(response);
    });
  }

  Future addTag(String tag) async {
    if (tags.map((e) => e.tag).toList().contains(tag)) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              '${LocaleKeys.tr_data_tag.tr} $tag ${LocaleKeys.error_data_already_exists.tr}')));
      throw Exception('Failed to add tag $tag: tag already exists.');
    }
    Either<Exception, TagModel> zResponse =
        await client.addTag(TagDTO(tag: tag));
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception('Failed to add tag $tag: Connection Error: $exception');
    }, (tagModel) {
      return tagModel;
    });
  }

  Future deleteTag(int id) async {
    Either<Exception, dio.Response> zResponse = await client.deleteTag(id);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception('tag deletion failed: Connection Error: $exception');
    }, (response) {
      return response;
    });
  }

  Future getTags() async {
    Either<Exception, List<TagModel>> zResponse = await client.getTagsList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future updateImage() async {
    ImageDTO dto = ImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, ImageModel> zResponse = await client.uploadImage(dto);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle Error
    }, (imageModel) {
      return imageModel;
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    }
    return null;
  }

  String? inStockValidator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    } else if (int.parse(v) < 0) {
      return LocaleKeys.error_data_invalid_input_error.tr;
    }
    return null;
  }

  String? tagsValidator(String? tagsSet) {
    if (productTags.isEmpty) {
      return LocaleKeys.error_data_at_least_one_tag_should_be_specified.tr;
    }
    return null;
  }

  @override
  void onInit() async {
    productID = int.parse(Get.parameters['productID']!);
    editingMode.value = Get.parameters['editingMode']?.isNotEmpty ?? false;
    if (productID != 0) {
      await initProduct(productID);
      initForm();
    } //TODO handle parameter retrieval failure
    tags.addAll(await getTags());
    super.onInit();
  }

  @override
  void refresh() async {
    tags.clear();
    tags.addAll(await getTags());
    super.refresh();
  }
}
