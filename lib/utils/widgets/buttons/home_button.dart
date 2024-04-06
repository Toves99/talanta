import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';

import '../../../screens/personality_test/success_personality_test.dart';

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  String? title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.contentColorPurple,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
