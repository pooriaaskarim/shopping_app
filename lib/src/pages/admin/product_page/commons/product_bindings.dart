import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/product_page/controllers/product_controller.dart';

class AdminProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminProductController());
  }
}
