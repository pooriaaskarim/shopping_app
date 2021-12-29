import 'package:flutter/material.dart';
import 'package:shopping_app/shopping_app.dart';

class AppIcon extends StatelessWidget {
  final double radius;
  final Color? backgroundColor, iconColor;

  const AppIcon(
      {required this.radius,
      this.backgroundColor = const Color(0xfffff2e9),
      this.iconColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(Utils.largePadding),
        child: Image.asset(
          'lib/assets/images/app_icon.png',
          package: 'shopping_app',
          fit: BoxFit.scaleDown,
          color: iconColor,
        ),
      ),
    );
  }
}
