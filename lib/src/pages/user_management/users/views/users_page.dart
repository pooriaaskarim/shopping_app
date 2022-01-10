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
          }),
    );
  }

  Widget getListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.users.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Utils.mediumPadding, vertical: Utils.tinyPadding),
          child: Container(
            padding: EdgeInsets.all(Utils.largePadding),
            decoration: BoxDecoration(
                color: MaterialTheme.enabledCardColor,
                borderRadius: BorderRadius.circular(13)),
            child: ListTile(
              leading: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 30.0,
                    color: (controller.users[index].isAdmin)
                        ? MaterialTheme.primaryColor[500]
                        : MaterialTheme.secondaryColor[500],
                  ),
                  Text(
                    '@${controller.users[index].username}',
                    textDirection: TextDirection.ltr,
                  )
                ],
              ),
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: Utils.largePadding),
                child: Text(
                  '${controller.users[index].name} ${controller.users[index].surname}',
                ),
              ),
              onTap: () {},
            ),
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
