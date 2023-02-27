import 'package:flutter/material.dart';

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