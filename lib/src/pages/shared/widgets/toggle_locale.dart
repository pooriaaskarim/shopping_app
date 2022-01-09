import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxList locales = [
  ['en', 'US'],
  ['fa', 'IR']
].obs;
void _toggleLocale() {
  Get.updateLocale(Locale(locales[0][0], locales[0][1]));
  locales.add(locales.removeAt(0));
}

Widget toggleLocaleButton({Color color = const Color(0xffc25200)}) {
  return Obx(() => IconButton(
      onPressed: () {
        _toggleLocale();
      },
      padding: EdgeInsets.zero,
      icon: Row(
        textDirection: TextDirection.ltr,
        children: [
          Icon(Icons.language, color: color),
          Text(
            locales[1][0],
            style: TextStyle(color: color),
          )
        ],
      )));
}
