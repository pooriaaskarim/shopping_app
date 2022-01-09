import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';
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
              child: _imagePicker(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: LocaleKeys.tr_data_enter_product_name.tr,
                labelText: LocaleKeys.tr_data_name.tr,
              ),
              enabled: controller.editingMode.value,
              validator: controller.validator,
              controller: controller.nameController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '#',
                labelText: LocaleKeys.tr_data_in_Stock.tr,
              ),
              enabled: controller.editingMode.value,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: controller.inStockController,
              validator: controller.inStockValidator,
            ),
          ),
          Padding(
            //Description Field
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: LocaleKeys.tr_data_description.tr,
                labelText: LocaleKeys.tr_data_description.tr,
              ),
              enabled: controller.editingMode.value,
              maxLines: 5,
              minLines: 3,
              validator: controller.validator,
              controller: controller.descriptionController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '123,456,789',
                labelText: LocaleKeys.tr_data_price.tr,
                prefixText: '\$', //TODO: handle price formatting
              ),
              enabled: controller.editingMode.value,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              validator: controller.validator,
              controller: controller.priceController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: (controller.editingMode.value) ? _tagsFormField() : null,
          ),
          Obx(() {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Utils.largePadding, vertical: Utils.smallPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var item in controller.productTags)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Utils.tinyPadding),
                        child: Container(
                            padding: EdgeInsets.all(Utils.tinyPadding),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: MaterialTheme.secondaryColor[300]),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Utils.tinyPadding),
                                  child: (controller.editingMode.value)
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: IconButton(
                                            color: MaterialTheme
                                                .secondaryColor[700],
                                            padding: EdgeInsets.zero,
                                            visualDensity:
                                                VisualDensity.compact,
                                            tooltip:
                                                LocaleKeys.tr_data_pop_tag.tr,
                                            iconSize: 20,
                                            icon: const Icon(Icons.clear),
                                            onPressed: () => controller
                                                .productTags
                                                .remove(item),
                                          ),
                                        )
                                      : null,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Utils.tinyPadding),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: MaterialTheme.primaryColor[50]),
                                  ),
                                ),
                              ],
                            )),
                      )
                  ],
                ),
              ),
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.largePadding, vertical: Utils.smallPadding),
            child: (controller.editingMode.value)
                ? ValueBuilder<bool?>(
                    initialValue: controller.product.value!.isEnabled,
                    builder: (snapshot, updater) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: controller.isEnabled.value,
                            onChanged: (value) {
                              controller.isEnabled.value = value!;
                              updater(value);
                            }),
                        Text((controller.isEnabled.value)
                            ? LocaleKeys.tr_data_product_enabled.tr
                            : LocaleKeys.tr_data_product_disabled.tr)
                      ],
                    ),
                  )
                : null,
          )
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
              shoppingButton(),
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 30,
                color: MaterialTheme.primaryColor[700],
                icon: const Icon(
                  Icons.favorite,
                ),
                onPressed: () {},
              )
            ]
          : [
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 30,
                color: MaterialTheme.primaryColor[700],
                icon: const Icon(
                  Icons.favorite,
                ),
                onPressed: () {},
              )
            ],
    );
  }

  Widget _tagsFormField() {
    return RawAutocomplete<TagModel>(
      textEditingController: controller.tagController,
      focusNode: FocusNode(),
      optionsBuilder: (v) {
        if (v.text.isEmpty) {
          return [];
        }
        return controller.tags.where((suggestedTagModel) =>
            suggestedTagModel.tag.toLowerCase().contains(v.text.toLowerCase()));
      },
      fieldViewBuilder: (BuildContext context, tagController, focusNode,
          VoidCallback onFieldSubmitted) {
        return ValueBuilder<String?>(
            initialValue: tagController.text,
            builder: (String? snapshot, Function(String?) updater) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys
                      .tr_data_product_tags.tr, //ToDo:change hint text
                  labelText: LocaleKeys.tr_data_tags.tr,
                  suffixIcon: IconButton(
                      color: Color(snapshot!.isEmpty ? 0xff707070 : 0xffc25200),
                      onPressed: () async {
                        if (snapshot.isNotEmpty) {
                          TagModel tag =
                              await controller.addTag(tagController.text);
                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${LocaleKeys.tr_data_tag.tr} ${tag.tag} ${LocaleKeys.tr_data_added.tr}.'),
                                  action: SnackBarAction(
                                      label: LocaleKeys.tr_data_undo.tr,
                                      onPressed: () {
                                        controller.deleteTag(tag.id);
                                      })));
                          controller.refresh();
                          tagController.clear();
                          updater(tagController.text);
                        }
                      },
                      icon: const Icon(Icons.add)),
                ),
                onChanged: (value) {
                  updater(value);
                },
                focusNode: focusNode,
                controller: tagController,
                validator: controller.tagsValidator,
              );
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<TagModel> onSelected,
          Iterable<TagModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            type: MaterialType.canvas,
            child: SizedBox(
              width: 300,
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    style: ListTileStyle.list,
                    onTap: () => onSelected(options.elementAt(index)),
                    title: Text(
                      options.elementAt(index).tag,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.deleteTag(options.elementAt(index).id);
                        controller.refresh();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (v) {
        controller.productTags.add(v.tag);
        controller.tagController.clear();
        // print('${controller.productTags}');
      },
    );
  }

  Widget _imagePicker(BuildContext context) {
    return Obx(() => Container(
          height: MediaQuery.of(Get.context!).size.width,
          width: MediaQuery.of(Get.context!).size.width,
          decoration: BoxDecoration(
              color: MaterialTheme.primaryColor[300],
              borderRadius: BorderRadius.circular(13)),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              GestureDetector(
                onTap: () {
                  controller.productImagerHandler.imagePicker(context);
                },
                child: controller.productImagerHandler.imageFile.value != null
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(Utils.tinyPadding),
                        decoration: BoxDecoration(
                            color: MaterialTheme.primaryColor[300],
                            borderRadius: BorderRadius.circular(13)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.file(
                            controller.productImagerHandler.imageFile.value!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    : Container(
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(Utils.tinyPadding),
                        decoration: BoxDecoration(
                            color: MaterialTheme.primaryColor[300]
                                ?.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(13)),
                        width: 150,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: (controller.productImage.value == null)
                              ? Center(
                                  child: shoppingAppCircularProgressIndicator())
                              : Image.memory(
                                  controller.productImage.value!.image,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(Utils.largePadding),
                child: (controller.editingMode.value)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (controller.productImagerHandler.imageFile.value !=
                              null)
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: MaterialTheme.primaryColor[300]!
                                      .withOpacity(.5)),
                              child: IconButton(
                                iconSize: 20,
                                color: MaterialTheme.primaryColor[700],
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  controller.productImagerHandler.imageFile
                                      .value = null;
                                },
                              ),
                            ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MaterialTheme.primaryColor[300]!
                                    .withOpacity(.5)),
                            child: IconButton(
                              iconSize: 20,
                              color: MaterialTheme.primaryColor[700],
                              icon: const Icon(
                                Icons.edit,
                              ),
                              onPressed: () {
                                controller.productImagerHandler
                                    .imagePicker(context);
                              },
                            ),
                          )
                        ],
                      )
                    : null,
              )
            ],
          ),
        ));
  }
}
