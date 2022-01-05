import 'package:flutter/cupertino.dart';
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
                    child: Padding(
                      padding: EdgeInsets.all(Utils.largePadding),
                      child: _imagePicker(context),
                    ),
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Utils.tinyPadding),
                                child: Container(
                                    padding: EdgeInsets.all(Utils.tinyPadding),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            MaterialTheme.secondaryColor[300]),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Utils.tinyPadding),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: IconButton(
                                              color: MaterialTheme
                                                  .secondaryColor[700],
                                              padding: EdgeInsets.zero,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              // padding: EdgeInsets.all(
                                              //     Utils.tinyPadding),
                                              tooltip: 'Pop Tag',
                                              iconSize: 20,
                                              icon: const Icon(Icons.clear),
                                              onPressed: () => controller
                                                  .productTags
                                                  .remove(item),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Utils.tinyPadding),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                color: MaterialTheme
                                                    .primaryColor[50]),
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
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: controller.isEnabled.value,
                              onChanged: (value) {
                                controller.isEnabled.value = value!;
                              }),
                          Text((controller.isEnabled.value)
                              ? 'Product Enabled'
                              : 'Product Disabled')
                        ],
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        color: MaterialTheme.primaryColor[700],
                        icon: const Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          formKey.currentState!.reset();
                          controller.productTags.clear();
                        },
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          color: MaterialTheme.primaryColor[700],
                          icon: const Icon(
                            Icons.check,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.addProduct();
                            }
                          })
                    ],
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
        return controller.tags.where((suggestedTagModel) =>
            suggestedTagModel.tag.toLowerCase().contains(v.text.toLowerCase()));
        // .contains(v.text));
      },
      fieldViewBuilder: (BuildContext context, tagController, focusNode,
          VoidCallback onFieldSubmitted) {
        return ValueBuilder<String?>(
            initialValue: tagController.text,
            builder: (String? snapshot, Function(String?) updater) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'Product Tags', //ToDo:change hint text
                  labelText: 'Tags',
                  suffixIcon: IconButton(
                      color: Color(snapshot!.isEmpty ? 0xff707070 : 0xffc25200),
                      onPressed: () async {
                        if (snapshot!.isNotEmpty) {
                          AdminAddProductTagModel tag =
                              await controller.addTag(tagController.text);
                          ScaffoldMessenger.of(Get.context!)
                              .showSnackBar(SnackBar(
                                  content: Text('Tag ${tag.tag} Added.'),
                                  action: SnackBarAction(
                                      label: 'Undo',
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
                // onFieldSubmitted: (_) => onFieldSubmitted,
                controller: tagController,
                validator: controller.tagsValidator,
              );
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AdminAddProductTagModel> onSelected,
          Iterable<AdminAddProductTagModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            type: MaterialType.canvas,
            child: Container(
              color: MaterialTheme.primaryColor[300],
              constraints: const BoxConstraints(
                  maxWidth: 300, minHeight: 50, maxHeight: 125),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                // shrinkWrap: true,
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
                        showDialog(
                            context: Get.context!,
                            builder: (context) => AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text('Delete tag?'),
                                  actions: <Widget>[
                                    TextButton(
                                      autofocus: true,
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.deleteTag(
                                            options.elementAt(index).id);
                                        controller.refresh();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ));
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
                    if (controller.productImagerHandler.imageFile.value != null)
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
                            controller.productImagerHandler.imageFile.value =
                                null;
                          },
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              MaterialTheme.primaryColor[300]!.withOpacity(.5)),
                      child: IconButton(
                        iconSize: 20,
                        color: MaterialTheme.primaryColor[700],
                        icon: const Icon(
                          Icons.camera_alt,
                        ),
                        onPressed: () {
                          controller.productImagerHandler.imagePicker(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
