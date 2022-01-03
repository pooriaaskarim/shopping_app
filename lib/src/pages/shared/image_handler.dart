//Product Picture Operations
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {
  final ImagePicker _picker = ImagePicker();

  Rxn<File> imageFile = Rxn<File>();

//Pick From Gallery
  Future<void> imageHandler() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      imageFile.value = File(xFile.path);
    }
  }

//Pick From Camera
  Future<void> photoHandler() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      imageFile.value = File(xFile.path);
    }
  }

//Pop a bottom sheet to choose from gallery or take a photo / delete photo
  void imagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imageHandler();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take a photo'),
                  onTap: () {
                    photoHandler();
                    Navigator.of(context).pop();
                  },
                ),
                if (imageFile.value != null)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Remove Photo'),
                    onTap: () {
                      imageFile.value = null;
                      Navigator.of(context).pop();
                    },
                  )
              ],
            ),
          );
        });
  }
}
