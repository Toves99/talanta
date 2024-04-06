// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/home_button.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ErrorPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ErrorPage> {
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
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/error.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Oops! An Error Occured",
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 36,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "An error occurred when we are submitting your personality test, please try again later! ",
                style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 17,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the home page shortly\nor click here to return to home page",
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
