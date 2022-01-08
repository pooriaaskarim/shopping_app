import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/search/controllers/search_controller.dart';

class AdminSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminSearchController());
  }
}
