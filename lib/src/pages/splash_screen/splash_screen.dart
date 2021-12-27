import 'package:flutter/material.dart';
import 'package:shopping_app/shopping_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _appIconWrapper(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Shopping App',
                  style: TextStyle(
                      color: MaterialTheme.primaryColor[50],
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                CircularProgressIndicator(
                  backgroundColor: MaterialTheme.primaryColor[300],
                  color: MaterialTheme.secondaryColor[500],
                  strokeWidth: 1.5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appIconWrapper() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: MaterialTheme.primaryColor[50],
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'lib/assets/images/app_icon.png',
        package: 'shopping_app',
        fit: BoxFit.scaleDown,
        scale: 2.6,
      ),
    );
  }
}
