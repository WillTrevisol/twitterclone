import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {

  final String profilePicure;
  final int radius;

  const DefaultCircleAvatar({
    super.key,
    required this.profilePicure,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        profilePicure,
      ),
      radius: 30,
    );
  }
}