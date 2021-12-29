import 'package:flutter/material.dart';
import 'package:shopping_app/shopping_app.dart';

Widget ShoppingAppCircularProgressIndicator() {
  return CircularProgressIndicator(
    backgroundColor: MaterialTheme.primaryColor[300],
    color: MaterialTheme.secondaryColor[500],
    strokeWidth: 1.5,
  );
}
