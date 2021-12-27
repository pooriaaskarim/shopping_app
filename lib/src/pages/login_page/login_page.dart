import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'lib/assets/images/login_BG.png',
        package: 'shopping_app',
      )
    ]);
  }
}
