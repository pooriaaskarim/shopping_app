import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/controllers/add_product_page_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}
