import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/controllers/add_product_page_controller.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_model.dart';

class AdminAddProductPage extends StatelessWidget {
  AdminAddProductPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Add Product',
        )),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(Utils.largePadding),
              child: Column(
                children: [
                  Center(
                    child: _imagePicker(context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter product\'s name',
                        labelText: 'Name',
                      ),
                      validator: controller.validator,
                      controller: controller.nameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '#',
                        labelText: 'In Stock',
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: controller.inStockController,
                      validator: controller.inStockValidator,
                    ),
                  ),
                  Padding(
                    //Description Field
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        labelText: 'Description',
                      ),
                      maxLines: 5,
                      minLines: 3,
                      validator: controller.validator,
                      controller: controller.descriptionController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '123,456,789',
                        labelText: 'Price',
                        prefixText: '\$', //TODO: handle price formatting
                      ),
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
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: _autocompleteFormField(),
                  ),
                  Obx(() {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.largePadding,
                          vertical: Utils.smallPadding),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in controller.productTags)
                              Chip(
                                backgroundColor:
                                    MaterialTheme.secondaryColor[300],
                                deleteIconColor:
                                    MaterialTheme.secondaryColor[700],
                                visualDensity: VisualDensity.compact,
                                deleteIcon: const Icon(Icons.clear),
                                onDeleted: () =>
                                    controller.productTags.remove(item),
                                deleteButtonTooltipMessage:
                                    'Delete tag from server!',
                                useDeleteButtonTooltip: true,
                                label: Text(
                                  item,
                                  style: TextStyle(
                                      color: MaterialTheme.primaryColor[50]),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.addProduct();
                          }
                        },
                        child: Text(
                          'Add Product',
                          style:
                              TextStyle(color: MaterialTheme.primaryColor[50]),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _autocompleteFormField() {
    return RawAutocomplete<AdminAddProductTagModel>(
      textEditingController: controller.tagController,
      focusNode: FocusNode(),
      optionsBuilder: (v) {
        if (v.text.isEmpty) {
          return [];
        }
        return controller.tags.where((suggestedTagModel) => suggestedTagModel
            .tag
            .toLowerCase()
            .startsWith(v.text.toLowerCase()));
        // .contains(v.text));
      },
      fieldViewBuilder: (BuildContext context, tagController, focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          decoration: InputDecoration(
              hintText: 'tag1, tag2,', //ToDo:change hint text
              labelText: 'Tags',
              suffixIcon: tagController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        if (tagController.text.isNotEmpty) {
                          controller.addTag(tagController.text);
                          controller.refresh();
                          tagController.clear();
                        }
                      },
                      icon: const Icon(Icons.add))
                  : const Icon(
                      Icons.add,
                      color: Colors.grey,
                    )),
          focusNode: focusNode,
          // onFieldSubmitted: (_) => onFieldSubmitted,
          controller: tagController,
          validator: controller.tagsValidator,
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AdminAddProductTagModel> onSelected,
          Iterable<AdminAddProductTagModel> options) {
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
    return Obx(() => Padding(
          padding: EdgeInsets.all(Utils.largePadding),
          child: Container(
            height: MediaQuery.of(Get.context!).size.width,
            width: MediaQuery.of(Get.context!).size.width,
            decoration: BoxDecoration(
                color: MaterialTheme.primaryColor[300],
                borderRadius: BorderRadius.circular(13)),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                controller.productImagerHandler.imageFile.value != null
                    ? GestureDetector(
                        onTap: () {
                          controller.productImagerHandler.imagePicker(context);
                        },
                        child: Container(
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
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.productImagerHandler.imagePicker(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: MaterialTheme.primaryColor[300]
                                  ?.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(13)),
                          width: 150,
                          height: 150,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(Utils.largePadding),
                  child: Row(
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
                            icon: Icon(
                              Icons.delete,
                              color: MaterialTheme.primaryColor[700],
                            ),
                            onPressed: () {
                              controller.productImagerHandler.imageFile.value =
                                  null;
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
                          icon: Icon(
                            Icons.camera_alt,
                            color: MaterialTheme.primaryColor[700],
                          ),
                          onPressed: () {
                            controller.productImagerHandler
                                .imagePicker(context);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
