import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/theme/theme.dart';

void showSnackBar({required BuildContext context, required String content, bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Pallete.whiteColor,
            fontSize: 16,
          ),
        ),
        backgroundColor: isError ? Pallete.redColor : Pallete.blueColor,
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker imagePicker = ImagePicker();
  final imagesFile = await imagePicker.pickMultiImage();
  if (imagesFile.isNotEmpty) {
    for (final image in imagesFile) {
      images.add(File(image.path));
    }
  }

  return images;
}