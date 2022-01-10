import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/widgets/app_icon_wrapper.dart';
import 'package:shopping_app/src/pages/shared/widgets/custom_circular_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAndToNamed(RouteNames.loginPage);
    });
    super.initState();
  }

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
                ),
                const SizedBox(height: 50),
                shoppingAppCircularProgressIndicator()
              ],
            ),
            // TextButton(
            //     autofocus: true,
            //     onPressed: () => Get.offAndToNamed(RouteNames.loginPage),
            //     child: Text(
            //       'next',
            //       style: Theme.of(context).textTheme.bodyText1,
            //     ))
          ],
        ),
      ),
    );
  }
}
