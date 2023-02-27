import 'package:flutter/material.dart';

import '../theme/theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key, 
    required this.onPressed, 
    required this.label, 
    this.backgroundColor = Pallete.whiteColor, 
    this.labelColor = Pallete.backgroundColor,
  });

  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Chip(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        label: Text(label),
        labelStyle: TextStyle(
            color: labelColor,
            fontSize: 16,
          ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }
}