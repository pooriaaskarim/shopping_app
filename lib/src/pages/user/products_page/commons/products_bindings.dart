import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user/products_page/controllers/products_page_controller.dart';

class UserProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProductsController());
  }
}
