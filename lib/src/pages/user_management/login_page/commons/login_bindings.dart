import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user_management/login_page/controllers/login_page_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
