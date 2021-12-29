import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/user_management/signup_page/controllers/signup_page_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

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
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        labelText: 'Name',
                      ),
                      validator: controller.validator,
                      controller: controller.nameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your surname',
                        labelText: 'Surname',
                      ),
                      validator: controller.validator,
                      controller: controller.surnameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Enter your username',
                          labelText: 'Username',
                          suffixIcon: Icon(Icons.person)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.usernameValidator,
                      controller: controller.usernameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: Obx(() => TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: controller.passwordIsVisible[0]['icon'],
                              onPressed: () {
                                controller.passwordIsVisible.add(
                                    controller.passwordIsVisible.removeAt(0));
                              },
                            ),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: controller.passwordIsVisible[0]['value'],
                          controller: controller.passwordController,
                          validator: controller.passwordValidator,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: Obx(() => TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: controller.passwordIsVisible[0]['icon'],
                              onPressed: () {
                                controller.passwordIsVisible.add(
                                    controller.passwordIsVisible.removeAt(0));
                              },
                            ),
                            hintText: 'Enter your password again',
                            labelText: 'Re-type Password',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: controller.passwordIsVisible[0]['value'],
                          controller: controller.retypePasswordController,
                          validator: controller.retypePasswordValidator,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Enter your address',
                        labelText: 'Address',
                      ),
                      controller: controller.addressController,
                      validator: controller.validator,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Utils.largePadding),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                          controller.signUp();
                        },
                        child: Text(
                          'Sign Me Up',
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
}
