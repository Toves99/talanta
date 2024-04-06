// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/home_button.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: screenHeight / 8,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: AppColors.contentColorPurple,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: GoogleFonts.poppins(
                color: AppColors.contentColorPurple,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Your Personality Test Has Been Submitted Successfully🏆",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "To view your personality results and occupation recommendations return to the home page",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xfff566370),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: HomeButton(
                title: 'Dashboard',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                        isPaid: false,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
