import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';
import 'package:shopping_app/src/pages/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:shopping_app/src/pages/shared/widgets/shopping_button.dart';
import 'package:shopping_app/src/pages/user/products_page/controllers/products_controller.dart';

class UserProductsPage extends StatelessWidget {
  UserProductsPage({Key? key}) : super(key: key);
  final controller = Get.find<UserProductsController>();

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: _userProductsAppBar(_scaffoldKey),
        drawer: _userProductsDrawer(),
        body: RefreshIndicator(
          onRefresh: () => controller.initPage(refresh: true),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() => Padding(
                    padding: EdgeInsets.all(Utils.smallPadding),
                    child: SizedBox(
                      width: MediaQuery.of(Get.context!).size.width,
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
                  ))),
        ));
  }

  AppBar _userProductsAppBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    return AppBar(
      title: Text(
        LocaleKeys.tr_data_products.tr,
      ),
      leading: Wrap(
        direction: Axis.vertical,
        children: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed(RouteNames.userSearchPage);
            },
            icon: Stack(
              alignment: Alignment.topCenter,
              children: [
                const Icon(Icons.shopping_cart),
                Obx(() => Container(
                      decoration: BoxDecoration(
                          color:
                              MaterialTheme.primaryColor[300]!.withOpacity(0.5),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: (controller.user.value == null)
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: shoppingAppCircularProgressIndicator())
                          : Text(
                              '${controller.user.value!.cart.length}',
                              style: TextStyle(
                                  color: MaterialTheme.primaryColor[50],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                    ))
              ],
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Get.toNamed(RouteNames.userSearchPage);
          },
          icon: const Icon(Icons.sort),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(RouteNames.userSearchPage,
                parameters: {'userID': '${controller.user.value!.id}'});
          },
          icon: const Icon(Icons.search),
          padding: EdgeInsets.zero,
        )
      ],
    );
  }

  Widget _productCard(int index) {
    return GestureDetector(
      onTap: () => Get.toNamed(RouteNames.userProduct, parameters: {
        'productID': '${controller.productsList[index].id}',
        'userID': "${controller.user.value!.id}"
      }),
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        padding: EdgeInsets.all(Utils.mediumPadding),
        decoration: BoxDecoration(
            color: (controller.productsList[index].inStock > 0)
                ? MaterialTheme.enabledCardColor
                : MaterialTheme.disabledCardColor,
            borderRadius: BorderRadius.circular(13)),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Utils.mediumPadding),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.productsList[index].name),
                      Text(
                          '${LocaleKeys.tr_data_products_in_stock.tr} ${controller.productsList[index].inStock}'),
                      Text(
                        controller.productsList[index].description,
                        maxLines: 3,
                        // softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          '${LocaleKeys.tr_data_price.tr} ${controller.productsList[index].price}'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item
                                in controller.productsList[index].tags)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Utils.tinyPadding),
                                child: Container(
                                    padding: EdgeInsets.all(Utils.tinyPadding),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            MaterialTheme.secondaryColor[300]),
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
                      ),
                      (controller.productsList[index].inStock > 0)
                          ? shoppingButton(
                              user: controller.user.value!,
                              product: controller.productsList[index])
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _productImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          FutureBuilder<ImageModel>(
            future: controller.getProductImage(controller.productsList[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!.image,
                  fit: BoxFit.fitWidth,
                );
              } else {
                return Center(child: shoppingAppCircularProgressIndicator());
              }
            },
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
                  child: ValueBuilder<bool?>(
                    initialValue: controller.user.value!.favorites
                        .contains(controller.productsList[index].id),
                    builder: (snapshot, updater) {
                      return IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (snapshot!) {
                              controller.user.value!.favorites
                                  .remove(controller.productsList[index].id);
                              controller.updateUserFavorites();
                              updater(controller.user.value!.favorites
                                  .contains(controller.productsList[index].id));
                            } else {
                              controller.user.value!.favorites
                                  .add(controller.productsList[index].id);
                              controller.updateUserFavorites();
                              updater(controller.user.value!.favorites
                                  .contains(controller.productsList[index].id));
                            }
                          },
                          icon: Icon(
                            (controller.user.value!.favorites
                                    .contains(controller.productsList[index].id)
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: MaterialTheme.primaryColor[700],
                          ));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _userProductsDrawer() {
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
                                          EdgeInsets.all(Utils.mediumPadding),
                                      child: Text(
                                        '${controller.user.value!.name} ${controller.user.value!.surname}',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(Utils.mediumPadding),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: Get.context!,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(LocaleKeys
                                                              .tr_data_confirm_logout
                                                              .tr),
                                                          content: Text(LocaleKeys
                                                              .tr_data_are_you_sure_you_want_to_logout
                                                              .tr),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              autofocus: true,
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                  LocaleKeys
                                                                      .tr_data_no
                                                                      .tr),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Get.offAndToNamed(
                                                                    RouteNames
                                                                        .loginPage);
                                                              },
                                                              child: Text(
                                                                  LocaleKeys
                                                                      .tr_data_yes
                                                                      .tr),
                                                            ),
                                                          ],
                                                        ));
                                              },
                                              tooltip:
                                                  LocaleKeys.tr_data_logout.tr,
                                              icon: Icon(
                                                Icons.exit_to_app,
                                                color: MaterialTheme
                                                    .primaryColor[700],
                                              )),
                                          Text(
                                            '@${controller.user.value!.username}',
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .headline6,
                                            textDirection: TextDirection.ltr,
                                          )
                                        ],
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
                            Icons.favorite,
                            color: MaterialTheme.primaryColor[700],
                          ),
                          title: Text(
                            LocaleKeys.tr_data_add_product.tr,
                          ),
                          onTap: () {}),
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
                            Icons.shopping_cart,
                            color: MaterialTheme.primaryColor[700],
                          ),
                          title: Text(LocaleKeys.tr_data_shopping_cart.tr),
                          onTap: () {
                            // Get.toNamed(RouteNames.usersPage);
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
