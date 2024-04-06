import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/personality_test/quiz_page.dart';

class DashboardNewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard1Screen(),
    );
  }
}

class Dashboard1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personality Profile Section
            SizedBox(height: 50.00),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('  Hello, Gathua!',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600)),
                const Icon(Icons.notifications),
              ],
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
            //   child: Text('  What would you like to do today?',
            //       textAlign: TextAlign.start,
            //       style: TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           fontFamily: 'Mulish')),
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover your Personality, and the Best 4 Careers that Match your most current personality in following four simple steps\n\n',
                    style: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // Bar Graph Section
            SizedBox(
              height: 20,
            ),
            Text(
              '1. Take about 10 to 15 minutes to complete a free personality test',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
            // View Best Careers Section

            Text(
              '\n2. View Your Personality Profile after completing the test for free',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),

            Text(
              '\n3. Make a subscription payment to view the best four careers that match your current personality profile',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color to blue
                ),
                onPressed: () {
                  // Check if the user has an active subscription or has paid
                  // If not, show the payment page
                  // Otherwise, navigate to the best careers page

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuestionsScreen(),
                    ),
                  );
                },
                child: Text(
                  'Take Personality Test',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            // View Best Careers Section
            // Container(
            //   margin: EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Notes, Rules & Conditions',
            //         style: GoogleFonts.poppins(
            //             color: const Color(0xfff566370),
            //             fontStyle: FontStyle.normal,
            //             fontWeight: FontWeight.w400),
            //       ),
            //       // Add your notes, rules, and conditions here
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
