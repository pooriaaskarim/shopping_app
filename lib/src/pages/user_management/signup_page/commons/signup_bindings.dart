import 'package:get/get.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/controllers/signup_page_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
