import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/product_page/controllers/product_page_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}
