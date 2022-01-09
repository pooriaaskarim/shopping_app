import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/admin/search/controllers/search_controller.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';

class AdminSearchPage extends StatelessWidget {
  AdminSearchPage({Key? key}) : super(key: key);
  final controller = Get.find<AdminSearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: RawAutocomplete<ProductModel>(
            textEditingController: controller.searchbarController,
            focusNode: FocusNode(),
            optionsBuilder: (v) {
              if (v.text.isEmpty) {
                return [];
              }
              return controller.productsList.where(
                  (e) => e.name.toLowerCase().contains(v.text.toLowerCase()));
            },
            fieldViewBuilder: (BuildContext context, controller, focusNode,
                VoidCallback onFieldSubmitted) {
              return TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: MaterialTheme.editingColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: MaterialTheme.editingColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  isDense: true,
                  prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 13,
                      ),
                      onPressed: () {
                        controller.clear();
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search), onPressed: () {}),
                ),
                controller: controller,
                focusNode: focusNode,
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<ProductModel> onSelected,
                Iterable<ProductModel> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  type: MaterialType.canvas,
                  child: SizedBox(
                    width: MediaQuery.of(Get.context!).size.width - 30,
                    height: MediaQuery.of(Get.context!).size.height - 100,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
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
                ),
              );
            },
            onSelected: (v) {
              // controller.productTags.add(v.tag);
              // controller.tagController.clear();
              // // print('${controller.productTags}');
            },
          ),
        ),
      ),
    );
  }

  Widget _productCard(int index) {
    return GestureDetector(
      onTap: () => Get.toNamed(RouteNames.adminProduct,
          parameters: {'productID': '${controller.productsList[index].id}'}),
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        padding: EdgeInsets.all(Utils.mediumPadding),
        decoration: BoxDecoration(
            color: (controller.productsList[index].isEnabled)
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
                padding: EdgeInsets.all(Utils.tinyPadding),
                child: SizedBox(
                  height: 200,
                  // width: 100,
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
                      )
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
      child: Image.memory(
        controller.productImagesList
            .where((imageModel) {
              return imageModel.id == controller.productsList[index].imageID;
            })
            .toList()
            .first
            .image,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
