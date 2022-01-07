import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/controllers/signup_page_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                      padding:
                          EdgeInsets.symmetric(vertical: Utils.largePadding),
                      child: _imagePicker(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.tr_data_enter_your_name.tr,
                        labelText: LocaleKeys.tr_data_name.tr,
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
                      decoration: InputDecoration(
                        hintText: LocaleKeys.tr_data_enter_your_surname.tr,
                        labelText: LocaleKeys.tr_data_surname.tr,
                      ),
                      validator: controller.validator,
                      controller: controller.surnameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: LocaleKeys.tr_data_enter_your_username.tr,
                          labelText: LocaleKeys.tr_data_username.tr,
                          suffixIcon: const Icon(Icons.person)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.usernameValidator,
                      controller: controller.usernameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: Obx(() => TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: controller.passwordIsVisible[0]['icon'],
                              onPressed: () {
                                controller.passwordIsVisible.add(
                                    controller.passwordIsVisible.removeAt(0));
                              },
                            ),
                            hintText: LocaleKeys.tr_data_enter_your_password.tr,
                            labelText: LocaleKeys.tr_data_password.tr,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: controller.passwordIsVisible[0]['value'],
                          controller: controller.passwordController,
                          validator: controller.passwordValidator,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: Obx(() => TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: controller.retypePasswordIsVisible[0]
                                  ['icon'],
                              onPressed: () {
                                controller.retypePasswordIsVisible.add(
                                    controller.retypePasswordIsVisible
                                        .removeAt(0));
                              },
                            ),
                            hintText:
                                LocaleKeys.tr_data_enter_your_password_again.tr,
                            labelText: LocaleKeys.tr_data_re_type_password.tr,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: controller.retypePasswordIsVisible[0]
                              ['value'],
                          controller: controller.retypePasswordController,
                          validator: controller.retypePasswordValidator,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.tr_data_enter_your_address.tr,
                        labelText: LocaleKeys.tr_data_address.tr,
                      ),
                      controller: controller.addressController,
                      validator: controller.validator,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.largePadding,
                        vertical: Utils.smallPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.signUp();
                          }
                        },
                        child: Text(
                          LocaleKeys.tr_data_sign_me_up.tr,
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

  GestureDetector _imagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.userImageHandler.imagePicker(context);
      },
      child: Obx(() => CircleAvatar(
            radius: 120,
            backgroundColor: MaterialTheme.primaryColor[300],
            child: controller.userImageHandler.imageFile.value != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Image.file(
                      controller.userImageHandler.imageFile.value!,
                      width: 235,
                      height: 235,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color:
                            MaterialTheme.secondaryColor[100]?.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(125)),
                    width: 235,
                    height: 235,
                    child: Icon(
                      Icons.camera_alt,
                      color: MaterialTheme.primaryColor[300],
                    ),
                  ),
          )),
    );
  }
}
