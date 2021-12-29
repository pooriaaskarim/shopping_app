import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/products_page/repositories/products_repository.dart';

class AdminPageController extends GetxController {
  final client = AdminProductsClient();

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }
}
