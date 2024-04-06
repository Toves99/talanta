import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  bool paymentAuthorized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
              Text('Payment Success',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.raleway(
                      color: const Color(0xfff566370),
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.home)),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 150, // Adjust the width and height as needed
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              shape: BoxShape.circle, // Create a circular shape
            ),
            child: Center(
              child: Icon(
                Icons.verified,
                color: Colors.green, // Icon color
                size: 60, // Icon size
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "Payment has been verified!",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "You will receive a Prompt from the mobile service provider to authorize the payment.",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color(0xfff566370),
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DashboardScreen(isPaid: true)),
                    (route) => false, // This will remove all previous routes.
              );
            },
            child: Text("Complete Payment",
                style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(height: 20.0),
          // ElevatedButton(
          //   onPressed: () {
          //     completePayment();
          //   },
          //   child: Text("VERIF"),
          // ),
        ],
      ),
    );
  }
}
