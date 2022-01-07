import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_image_dto.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_image_model.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_model.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_tag_dto.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_tag_model.dart';
import 'package:shopping_app/src/pages/admin/product_page/repositories/product_repository.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';

class AdminProductController extends GetxController {
  final client = ProductClient();
  int productID = 0;
  RxBool editingMode = false.obs;
  RxBool isEnabled = false.obs;
  Rxn<AdminProductModel> product = Rxn<AdminProductModel>();
  Rxn<AdminProductImageModel> productImage = Rxn<AdminProductImageModel>();
  RxList<AdminProductTagModel> tags = <AdminProductTagModel>[].obs;
  RxSet<String> productTags = <String>{}.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  ImageHandler productImagerHandler = ImageHandler();

  Future<AdminProductModel> getProduct(int productID) async {
    Either<Exception, AdminProductModel> zResponse =
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

  Future<AdminProductImageModel> getProductImage(int imageID) async {
    Either<Exception, AdminProductImageModel> zResponse =
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

  Future<AdminProductImageModel> uploadImage() async {
    AdminProductImageDTO dto = AdminProductImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, AdminProductImageModel> zResponse =
        await client.uploadImage(dto);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
      throw Left(
          Exception('Failed to add Image: Connection Error: $exception'));
    }, (imageModel) {
      return imageModel;
    });
  }

  Future toggleProduct() async {
    product.value!.isEnabled = isEnabled.value;
    Either<Exception, AdminProductModel> zResponse =
        await client.updateProduct(product.value!);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Connection Error'),
      ));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text.rich(TextSpan(children: [
          const TextSpan(text: 'Product '),
          TextSpan(
              text: '${model.name} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: model.isEnabled ? 'enabled.' : 'disabled')
        ])),
        duration: const Duration(seconds: 2),
      ));
      return model;
    });
  }

  Future updateProduct() async {
    int _imageID;
    if (productImagerHandler.imageFile.value != null) {
      AdminProductImageModel updateImageModel = await uploadImage();
      _imageID = updateImageModel.id;
    } else {
      _imageID = product.value!.imageID;
    }
    AdminProductModel updateModel = AdminProductModel(
        id: product.value!.id,
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        tags: productTags.toList(),
        inStock: int.parse(inStockController.text),
        imageID: _imageID,
        isEnabled: isEnabled.value);
    Either<Exception, AdminProductModel> zResponse =
        await client.updateProduct(updateModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t update product.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                updateProduct();
              })));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Product ${nameController.text} updated.')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      return model;
    });
  }

  Future deleteProduct(AdminProductModel productModel) async {
    Either<Exception, dio.Response> zResponse =
        await client.deleteProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Connection Error'),
      ));
      throw Exception(exception);
    }, (response) async {
      Either<Exception, dio.Response> zResponse =
          await client.deleteProductImage(productModel);
      zResponse.fold((exception) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Connection Error'),
        ));
        throw Exception(exception);
      }, (response) async {
        return Right(response);
      });
      return Right(response);
    });
  }

  Future addTag(String tag) async {
    if (tags.map((e) => e.tag).toList().contains(tag)) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('tag $tag already exists.')));
      throw Exception('Failed to add tag $tag: tag already exists.');
    }
    Either<Exception, AdminProductTagModel> zResponse =
        await client.addTag(AdminProductTagDTO(tag: tag));
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
      throw Exception('Failed to add tag $tag: Connection Error: $exception');
    }, (tagModel) {
      return tagModel;
    });
  }

  Future deleteTag(int id) async {
    Either<Exception, dio.Response> zResponse = await client.deleteTag(id);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
      throw Exception('tag deletion failed: Connection Error: $exception');
    }, (response) {
      return response;
    });
  }

  Future getTags() async {
    Either<Exception, List<AdminProductTagModel>> zResponse =
        await client.getTagsList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future updateImage() async {
    AdminProductImageDTO dto = AdminProductImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, AdminProductImageModel> zResponse =
        await client.uploadImage(dto);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle Error
    }, (imageModel) {
      return imageModel;
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }

  String? inStockValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    } else if (int.parse(v) < 0) {
      return 'Invalid input';
    }
    return null;
  }

  String? tagsValidator(String? tagsSet) {
    if (productTags.isEmpty) {
      return 'At least one tag should be specified';
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
