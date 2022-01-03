import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/admin/products_page/controllers/products_page_controller.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';

class AdminProductsPage extends StatelessWidget {
  AdminProductsPage({Key? key}) : super(key: key);
  final controller = Get.find<AdminProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
            style: TextStyle(color: MaterialTheme.primaryColor[700]),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(Utils.smallPadding),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(RouteNames.adminAddProduct);
            }),
        drawer: adminProductsDrawer(),
        body: const SingleChildScrollView(
            // child:
            ));
  }

  Widget adminProductsDrawer() {
    return SafeArea(
      child: Drawer(
          elevation: 25,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ListView(children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: MaterialTheme.primaryColor[300],
                      ),
                      child: Obx(() => Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    MaterialTheme.primaryColor[700],
                                radius: 50,
                                child: controller.user.value!.imageId != 0
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.memory(
                                          controller.userImage.value!.image,
                                          width: 97,
                                          height: 97,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: MaterialTheme
                                                .secondaryColor[100]
                                                ?.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        width: 97,
                                        height: 97,
                                        child: Icon(
                                          Icons.person,
                                          color:
                                              MaterialTheme.primaryColor[300],
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(Utils.largePadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(Utils.largePadding),
                                      child: Text(
                                        '${controller.user.value!.name} ${controller.user.value!.surname}',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(Utils.largePadding),
                                      child: Text(
                                        '@${controller.user.value!.username}',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))),
                  Padding(
                    padding: EdgeInsets.all(Utils.smallPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MaterialTheme.primaryColor[300],
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                          leading: Icon(
                            Icons.add,
                            color: MaterialTheme.primaryColor[700],
                          ),
                          title: const Text(
                            'Add Product',
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.adminAddProduct);
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.smallPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MaterialTheme.primaryColor[300],
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                          leading: Icon(
                            Icons.supervised_user_circle_outlined,
                            color: MaterialTheme.primaryColor[700],
                          ),
                          title: const Text(
                            'Users',
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.usersPage);
                          }),
                    ),
                  ),
                ]),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Shopping App',
                        style: TextStyle(
                            color: MaterialTheme.primaryColor[500],
                            fontSize: 20),
                      ),
                      AppIcon(
                        radius: 140,
                        backgroundColor: Colors.transparent,
                        iconColor: MaterialTheme.primaryColor[500],
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
