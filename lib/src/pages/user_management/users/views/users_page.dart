import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/user_management/users/controllers/users_controller.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);
  final controller = Get.find<UsersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Padding(
          padding: EdgeInsets.all(Utils.largePadding),
          child: Obx(() => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: getListView()))),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            controller.refresh();
            // SizedBox(
            //     height: MediaQuery.of(context).size.height,
            //     child: getListView());
          }),
    );
  }

  Widget getListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.users.value.list.length,
      itemBuilder: (context, index) {
        return Card(
          // color: MaterialTheme.enabledCardColor,
          child: ListTile(
            selectedTileColor: MaterialTheme.enabledCardColor,
            leading: Padding(
              padding: EdgeInsets.all(Utils.largePadding),
              child: const Icon(
                Icons.person,
                size: 30.0,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '${controller.users.value.list[index].name} ${controller.users.value.list[index].surname}',
                // style: const TextStyle(
                //     color: Color(0xffc4dae7), fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Get.toNamed('/user/${controller.users.value.list[index].id}');
            },
          ),
        );
      },
    );
  }
}

// void main() {
//   runApp(GetMaterialApp(
//     home: Users(),
//   ));
// }
