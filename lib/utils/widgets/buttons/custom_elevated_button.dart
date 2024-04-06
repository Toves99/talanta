import 'package:flutter/material.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';

class CustomElevatedButton extends StatefulWidget {
  final double width;
  final double height;
  // onPressed function
  final VoidCallback? onPressed;
  final Text buttonLabel;
  final Color backGroundColor;
  const CustomElevatedButton(
      {super.key,
      required this.width,
      this.height = 50,
      required this.onPressed,
      required this.buttonLabel,
      this.backGroundColor = AppColors.contentColorBlue});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(widget.backGroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
        child: widget.buttonLabel,
      ),
    );
  }
}
