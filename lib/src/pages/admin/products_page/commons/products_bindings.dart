import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/products_page/controllers/products_page_controller.dart';

class AdminProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminProductsController());
  }
}
