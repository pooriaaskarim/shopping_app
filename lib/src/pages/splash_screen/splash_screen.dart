import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';
import 'package:shopping_app/src/pages/shared/widgets/custom_circular_progress_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  // Future Function() delay = await Future.delayed(Duration(seconds: 5), () {Get.toNamed()});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppIcon(
              radius: 200.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Shopping App',
                  style: Theme.of(context).textTheme.headline3,
                  // style: TextStyle(
                  //     color: MaterialTheme.primaryColor[50],
                  //     fontSize: 34.0,
                  //     fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                ShoppingAppCircularProgressIndicator(),
              ],
            ),
            TextButton(
                autofocus: true,
                onPressed: () => Get.toNamed(RouteNames.loginPage),
                child: Text(
                  'next',
                  style: Theme.of(context).textTheme.bodyText1,
                ))
          ],
        ),
      ),
    );
  }
}
