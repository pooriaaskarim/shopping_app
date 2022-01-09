import 'package:flutter/material.dart';
import 'package:shopping_app/shopping_app.dart';

Widget shoppingButton() {
  return Container(
    height: 37,
    decoration: BoxDecoration(
        color: MaterialTheme.primaryColor,
        borderRadius: BorderRadiusDirectional.circular(50)),
    padding: EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.remove_circle,
            color: MaterialTheme.primaryColor[50],
          ),
// padding: EdgeInsets.zero,
        ),
        Text(
          "0",
          style: TextStyle(
              color: MaterialTheme.primaryColor[50],
              fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_circle, color: MaterialTheme.primaryColor[50]),
// padding: EdgeInsets.zero,
        ),
      ],
    ),
  );
}
