import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/admin/products_page/controllers/products_page_controller.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/product_model.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';

class AdminProductsPage extends StatelessWidget {
  AdminProductsPage({Key? key}) : super(key: key);
  final controller = Get.find<AdminProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products',
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
        drawer: _adminProductsDrawer(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      controller.refresh();
                    },
                    child: const Text('data')),
                Obx(() => Padding(
                      padding: EdgeInsets.all(Utils.smallPadding),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        // height: MediaQuery.of(Get.context!).size.height,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.productsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Utils.smallPadding,
                                  horizontal: Utils.mediumPadding),
                              child: _productCard(index),
                            );
                          },
                        ),
                      ),
                    )),
              ],
            )));
  }

  Container _productCard(int index) {
    return Container(
      width: MediaQuery.of(Get.context!).size.width,
      padding: EdgeInsets.all(Utils.mediumPadding),
      decoration: BoxDecoration(
          color: (controller.productsList[index].isEnabled)
              ? MaterialTheme.enabledCardColor
              : MaterialTheme.disabledCardColor,
          borderRadius: BorderRadius.circular(13)),
      child: Expanded(
        flex: 1,
        child: Row(
          children: [
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(Utils.tinyPadding),
              decoration: BoxDecoration(
                  color: MaterialTheme.primaryColor[300],
                  borderRadius: BorderRadius.circular(13)),
              child: _productImage(index),
            ),
            Padding(
              padding: EdgeInsets.all(Utils.tinyPadding),
              child: Container(
                height: 200,
                // width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.productsList[index].name),
                    Text(
                        'Products in stock ${controller.productsList[index].inStock}'),
                    Text(
                      controller.productsList[index].description,
                      maxLines: 3,
                      // softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Price ${controller.productsList[index].price}'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var item in controller.productsList[index].tags)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Utils.tinyPadding),
                              child: Container(
                                  padding: EdgeInsets.all(Utils.tinyPadding),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: MaterialTheme.secondaryColor[300]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Utils.tinyPadding),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color:
                                              MaterialTheme.primaryColor[50]),
                                    ),
                                  )),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ClipRRect _productImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.memory(
            controller.productImagesList
                .where((imageModel) {
                  return imageModel.id ==
                      controller.productsList[index].imageID;
                })
                .toList()[0]
                .image,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: EdgeInsets.all(Utils.mediumPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MaterialTheme.primaryColor[300]!.withOpacity(.5)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    color: MaterialTheme.primaryColor[700],
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text('Delete Product?'),
                                actions: <Widget>[
                                  TextButton(
                                    autofocus: true,
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.deleteProduct(
                                          controller.productsList[index].id);
                                      controller.refresh();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ));
                    },
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MaterialTheme.primaryColor[300]!.withOpacity(.5)),
                  child: Checkbox(
                      value: controller.productsList[index].isEnabled,
                      onChanged: (value) {
                        controller.productsList[index].isEnabled = value!;
                        controller.productsList[index] =
                            AdminProductModel.fromMap(
                                controller.productsList[index].toMap());
                        controller
                            .updateProduct(controller.productsList[index].id);
                      }),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MaterialTheme.primaryColor[300]!.withOpacity(.5)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    color: MaterialTheme.primaryColor[700],
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _productTileImage(int index) {
  //   return FutureBuilder(
  //     future:
  //         controller.getProductImage(controller.productsList[index].imageID),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: ShoppingAppCircularProgressIndicator());
  //       } else if (snapshot.hasData) {
  //         return Stack(
  //           fit: StackFit.passthrough,
  //           children: [
  //             Image.memory(
  //               snapshot.data.image,
  //               fit: BoxFit.fitWidth,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(Utils.mediumPadding),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Container(
  //                     height: 25,
  //                     width: 25,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         color:
  //                             MaterialTheme.primaryColor[300]!.withOpacity(.5)),
  //                     child: IconButton(
  //                       padding: EdgeInsets.zero,
  //                       iconSize: 20,
  //                       color: MaterialTheme.primaryColor[700],
  //                       icon: const Icon(
  //                         Icons.edit,
  //                       ),
  //                       onPressed: () {},
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 25,
  //                     width: 25,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         color:
  //                             MaterialTheme.primaryColor[300]!.withOpacity(.5)),
  //                     child: Checkbox(
  //                         value: controller.productsList[index].isEnabled,
  //                         onChanged: (value) {
  //                           controller.productsList[index].isEnabled = value!;
  //                           controller.productsList[index] =
  //                               AdminProductModel.fromMap(
  //                                   controller.productsList[index].toMap());
  //                         }),
  //                   ),
  //                   Container(
  //                     height: 25,
  //                     width: 25,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         color:
  //                             MaterialTheme.primaryColor[300]!.withOpacity(.5)),
  //                     child: IconButton(
  //                       padding: EdgeInsets.zero,
  //                       iconSize: 20,
  //                       color: MaterialTheme.primaryColor[700],
  //                       icon: const Icon(
  //                         Icons.delete,
  //                       ),
  //                       onPressed: () {},
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  //       } else {
  //         return const Center(child: Text('No Image'));
  //       }
  //     },
  //   );
  // }

  Widget _adminProductsDrawer() {
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
                                child: controller.user.value!.imageID != 0
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
