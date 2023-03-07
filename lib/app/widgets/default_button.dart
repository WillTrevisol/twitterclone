import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key, 
    this.onPressed, 
    required this.label, 
    required this.backgroundColor, 
    required this.labelColor,
  });

  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: 16,
        ), 
      ),
    );
  }
}