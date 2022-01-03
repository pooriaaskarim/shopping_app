import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user_management/users/controllers/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController());
  }
}
