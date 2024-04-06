import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard/dashboard.dart';
import 'add_payment_phone_number.dart';

class PackageSelectionPage extends StatelessWidget {
  final int personalityID;
  final Color color;

  // Constructor with required and optional parameters
  const PackageSelectionPage({
    Key? key,
    required this.personalityID,
    this.color = Colors.blue, // Optional parameter with a default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_sharp)),
                  Spacer(),
                  Text('Payment Screen',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.raleway(
                          color: const Color(0xfff566370),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  Spacer(),
                ],
              ),
              PackageCard(
                title: 'Pay As You Go Package',
                price: 'KES 100 ',
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPaymentPhoneNumberPage(
                        amount: 100,
                        personalityID: personalityID,
                      ),
                    ),
                  );
                },
                description: [
                  "Our Pay As You Go Package - the flexible choice for those seeking personalized insights at their own pace. With our Pay As You Go option, you pay only for what you need, when you need it. Here's what's included",
                  "Access to our comprehensive personality test questionnaire.",
                  "Receive a detailed report outlining your primary personality traits.",
                  "Unlock in-depth insights into your personality dynamics",
                  "Flexibility to explore additional features and insights as desired, without commitment.",
                  "Pay-per-insight pricing ensures you only pay for the insights you want to delve into."
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> description;
  final Function? onClick;

  PackageCard(
      {required this.title,
      required this.price,
      required this.description,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.workspace_premium,
                size: 32,
                color: Colors.blue,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.raleway(
                  color: const Color(0xfff566370),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              price,
              style: GoogleFonts.raleway(
                  color: Colors.blue,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: description
                  .map((line) => Text(
                        '▪ $line',
                        style: GoogleFonts.raleway(
                            color: const Color(0xfff566370),
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                onClick!();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueAccent,
                ),
                child: Center(
                    child: Text(
                  'Pay',
                  style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
