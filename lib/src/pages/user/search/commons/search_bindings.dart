import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user/search/controllers/search_controller.dart';

class UserSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSearchController());
  }
}
