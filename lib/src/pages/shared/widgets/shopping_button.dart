import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/cart_item_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';

Widget shoppingButton(
    {required UserModel user, required ProductModel product}) {
  int _getItemCount() {
    return (user.cart.map((e) => e.productID).contains(product.id))
        ? user.cart.where((e) => e.productID == product.id).first.count
        : 0;
  }

  return Container(
    height: 37,
    decoration: BoxDecoration(
        color: MaterialTheme.primaryColor,
        borderRadius: BorderRadiusDirectional.circular(50)),
    padding: EdgeInsets.zero,
    child: ValueBuilder<int?>(
      initialValue: _getItemCount(),
      builder: (snapshot, updater) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (user.cart.map((e) => e.productID).contains(product.id)) {
                user.cart.where((e) => e.productID == product.id).first.count--;
                if (user.cart
                        .where((e) => e.productID == product.id)
                        .first
                        .count ==
                    0) {
                  user.cart.removeWhere((e) => e.productID == product.id);
                }
                updater(_getItemCount());
              } else {
                return;
              }
            },
            icon: Icon(
              Icons.remove_circle,
              color: MaterialTheme.primaryColor[50],
            ),
          ),
          Text(
            snapshot.toString(),
            style: TextStyle(
                color: MaterialTheme.primaryColor[50],
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              if (user.cart.map((e) => e.productID).contains(product.id)) {
                user.cart.where((e) => e.productID == product.id).first.count++;
                updater(_getItemCount());
              } else {
                user.cart.add(CartItemModel(productID: product.id, count: 1));
                updater(_getItemCount());
              }
            },
            icon: Icon(Icons.add_circle, color: MaterialTheme.primaryColor[50]),
          ),
        ],
      ),
    ),
  );
}
