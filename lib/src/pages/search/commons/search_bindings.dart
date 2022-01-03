import 'package:get/get.dart';
import 'package:shopping_app/src/pages/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
