import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user/product_page/controllers/product_controller.dart';

class UserProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProductController());
  }
}
