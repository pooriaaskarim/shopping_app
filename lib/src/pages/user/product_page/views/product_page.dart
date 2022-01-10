import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:shopping_app/src/pages/shared/widgets/shopping_button.dart';
import 'package:shopping_app/src/pages/user/product_page/controllers/product_controller.dart';

class UserProductPage extends StatelessWidget {
  UserProductPage({Key? key}) : super(key: key);

  final controller = Get.find<UserProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Obx(() => (controller.product.value == null)
              ? Center(child: shoppingAppCircularProgressIndicator())
              : Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(Utils.largePadding),
                  child: Column(
                    children: [
                      _productCard(context),
                      const SizedBox(
                        height: 50,
                      ),
                      _bottomActionButtons(),
                    ],
                  ),
                )),
        ));
  }

  Widget _productCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (controller.product.value!.inStock > 0)
            ? MaterialTheme.enabledCardColor
            : MaterialTheme.disabledCardColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Form(
        child: Column(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Utils.largePadding, vertical: Utils.smallPadding),
              child: _productImage(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                labelText: LocaleKeys.tr_data_name.tr,
              ),
              initialValue: controller.product.value!.name,
              enabled: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                labelText: LocaleKeys.tr_data_in_Stock.tr,
              ),
              textDirection: TextDirection.ltr,
              initialValue: controller.product.value!.inStock.toString(),
              enabled: false,
            ),
          ),
          Padding(
            //Description Field
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                labelText: LocaleKeys.tr_data_description.tr,
              ),
              initialValue: controller.product.value!.description,
              enabled: false,
              maxLines: 5,
              minLines: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                labelText: LocaleKeys.tr_data_price.tr,
                // prefixText: '\$', //TODO: handle price formatting
              ),
              textDirection: TextDirection.ltr,
              initialValue: '\$ ${controller.product.value!.price}',
              enabled: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var item in controller.product.value!.tags)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Utils.tinyPadding),
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
                                  color: MaterialTheme.primaryColor[50]),
                            ),
                          )),
                    )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _bottomActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: (controller.product.value!.inStock > 0)
          ? [
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 30,
                color: MaterialTheme.primaryColor[700],
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () {},
              ),
              shoppingButton(
                  user: controller.user.value!,
                  product: controller.product.value!),
              _favoriteIcon()
            ]
          : [_favoriteIcon()],
    );
  }

  Widget _favoriteIcon() {
    return ValueBuilder<bool?>(
      initialValue: controller.user.value!.favorites
          .contains(controller.product.value!.id),
      builder: (snapshot, updater) {
        return IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (snapshot!) {
                controller.user.value!.favorites
                    .remove(controller.product.value!.id);
                controller.updateUserFavorites();
                updater(controller.user.value!.favorites
                    .contains(controller.product.value!.id));
              } else {
                controller.user.value!.favorites
                    .add(controller.product.value!.id);
                controller.updateUserFavorites();
                updater(controller.user.value!.favorites
                    .contains(controller.product.value!.id));
              }
            },
            icon: Icon(
              (controller.user.value!.favorites
                      .contains(controller.product.value!.id)
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: MaterialTheme.primaryColor[700],
            ));
      },
    );
  }

  Widget _productImage(BuildContext context) {
    return Obx(() => Container(
          height: MediaQuery.of(Get.context!).size.width,
          width: MediaQuery.of(Get.context!).size.width,
          decoration: BoxDecoration(
              color: MaterialTheme.primaryColor[300],
              borderRadius: BorderRadius.circular(13)),
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(Utils.tinyPadding),
            decoration: BoxDecoration(
                color: MaterialTheme.primaryColor[300],
                borderRadius: BorderRadius.circular(13)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: FutureBuilder<ImageModel>(
                future: controller
                    .getProductImage(controller.product.value!.imageID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.memory(
                      snapshot.data!.image,
                      fit: BoxFit.fitWidth,
                    );
                  } else {
                    return Center(
                      child: shoppingAppCircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }
}
