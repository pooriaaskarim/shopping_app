import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';
import 'package:shopping_app/src/pages/user_management/login_page/controllers/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(alignment: Alignment.topCenter, children: [
            Image.asset(
              'lib/assets/images/login_bg.png',
              package: 'shopping_app',
              fit: BoxFit.scaleDown,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                children: [
                  const AppIcon(radius: 250.0),
                  Padding(
                    padding: EdgeInsets.all(Utils.mediumPadding),
                    child: Text(
                      'Shopping App',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: 100),
                  loginForm(),
                ],
              ),
            )
          ]),
        ],
      ),
    ));
  }

  Widget loginForm() {
    return Form(
      key: formKey,
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Utils.largePadding),
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: LocaleKeys.tr_data_enter_your_username.tr,
                    labelText: LocaleKeys.tr_data_username.tr,
                    suffixIcon: const Icon(Icons.person)),
                validator: controller.validator,
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
                          controller.passwordIsVisible
                              .add(controller.passwordIsVisible.removeAt(0));
                        },
                      ),
                      hintText: LocaleKeys.tr_data_enter_your_password.tr,
                      labelText: LocaleKeys.tr_data_password.tr,
                    ),
                    obscureText: controller.passwordIsVisible[0]['value'],
                    controller: controller.passwordController,
                    validator: controller.validator,
                  )),
            ),
            // Padding(
            //   padding: EdgeInsets.all(Utils.largePadding),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Obx(() => Checkbox(
            //           value: controller.keepSignedIn.value,
            //           onChanged: (v) {
            //             controller.keepSignedIn.value = v!;
            //           })),
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(Utils.mediumPadding, 0, 0, 0),
            //         child: Text(
            //           LocaleKeys.tr_data_keep_me_logged_in.tr,
            //           style: const TextStyle(
            //               color: MaterialTheme.textColor, fontSize: 16.0),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(Utils.largePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: Text(
                        LocaleKeys.tr_data_login.tr,
                        style: TextStyle(color: MaterialTheme.primaryColor[50]),
                      )),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  //TODO: handle controller close before navigating to signup page
                  Get.toNamed(RouteNames.signupPage);
                },
                child: Text.rich(
                  TextSpan(
                      style: const TextStyle(color: MaterialTheme.textColor),
                      children: [
                        TextSpan(
                            text: '${LocaleKeys.tr_data_not_a_member.tr} '),
                        TextSpan(
                            text: LocaleKeys.tr_data_register_here.tr,
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
