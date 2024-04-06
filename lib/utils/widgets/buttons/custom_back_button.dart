import 'dart:io';

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  // onPressed function
  final VoidCallback? onPressed;
  final Color iconColor;

  const CustomBackButton(
      {Key? key, required this.onPressed, this.iconColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
