import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanta_new/screens/payments/add_payment_phone_number.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';
import 'package:talanta_new/screens/recommendations/career_recommendation.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';

class PaymentVerificationPage extends StatefulWidget {
  final String checkoutRequestID;
  final String personalityID;

  const PaymentVerificationPage(
      {Key? key, required this.checkoutRequestID, required this.personalityID})
      : super(key: key);

  @override
  _PaymentVerificationPageState createState() =>
      _PaymentVerificationPageState();
}

class _PaymentVerificationPageState extends State<PaymentVerificationPage> {
  bool paymentAuthorized = false;
  bool verifyingPayment = false;

  Future<void> verifyPayment() async {
    // Your API endpoint
    final String apiUrl = APIEndpoints.verifyPayment;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userID');

    // Request body
    Map<String, dynamic> requestBody = {
      "checkoutRequestID": widget.checkoutRequestID,
      "pid": userId,
      "personalityID": widget.personalityID
    };

    try {
      setState(() {
        verifyingPayment = true;
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Successful response
        Map<String, dynamic> responseData = jsonDecode(response.body);

        print("RESPERPWEORPWEROPWER \n\n\n${responseData.toString()}\n\n\n");

        String responseCode = responseData['message']['ResponseCode'];

        if (responseCode == "0") {
          // Payment verification successful
          setState(() {
            paymentAuthorized = true;
          });

          // Show a success message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Payment Successful ✅",
                style: GoogleFonts.raleway(
                    color: Colors.green,
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              content: Text(
                  "You have successfully completed the payment verification.",
                  style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400)),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var userID = prefs.getInt('userID');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendedCareers(
                          personalityId: int.parse(widget.personalityID),
                          userID: userID,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        } else {
          // Payment verification failed

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Payment Verification Failed',
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                content: Text(responseData['data']['ResponseDescription'],
                    style: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Retry Payment',
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AddPaymentPhoneNumberPage(
                                amount: 100,
                                personalityID:
                                    int.parse(widget.personalityID))),
                        (route) =>
                            false, // This will remove all previous routes.
                      );
                    },
                  ),
                  TextButton(
                    child: Text('Cancel',
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog.
                    },
                  ),
                ],
              );
            },
          );
          // Optionally, you can enable the "Retry Payment" button here
          // setState(() {
          //   verifyingPayment = false;
          // });
        }
      } else {
        // Error response
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Payment Verification Failed',
                  style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 17,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
              content: Text('We could not verify your payment!',
                  style: GoogleFonts.poppins(
                      color: const Color(0xfff566370),
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
              actions: <Widget>[
                TextButton(
                  child: Text('Retry Payment',
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => AddPaymentPhoneNumberPage(
                              amount: 100,
                              personalityID: int.parse(widget.personalityID))),
                      (route) => false, // This will remove all previous routes.
                    );
                  },
                ),
                TextButton(
                  child: Text('Cancel',
                      style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog.
                  },
                ),
              ],
            );
          },
        ); // setState(() {
        //   verifyingPayment = false;
        // });
      }
    } catch (error) {
      // Handle any exception that occurred during the API call
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Verification Failed',
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500)),
            content: Text(error.toString(),
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500)),
            actions: <Widget>[
              TextButton(
                child: Text('Retry Payment',
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => AddPaymentPhoneNumberPage(
                            amount: 100,
                            personalityID: int.parse(widget.personalityID))),
                    (route) => false, // This will remove all previous routes.
                  );
                },
              ),
              TextButton(
                child: Text('Cancel',
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
    } finally {
      // Ensure that the state is updated, even if an exception occurs
      setState(() {
        verifyingPayment = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the user from going back until payment is verified
        return !verifyingPayment;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // Disable going back until payment is verified
                      if (!verifyingPayment) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_sharp)),
                Spacer(),
                Text('Payment Verification',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                        color: const Color(0xfff566370),
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                Spacer(),
                IconButton(
                    onPressed: () {
                      // Disable going back until payment is verified
                      if (!verifyingPayment) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.home)),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.timelapse_sharp,
                  color: Colors.orange,
                  size: 60,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Verify your Payment!",
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
                  "You will receive an STK prompt from the mobile service provider to authorize the payment. After making the payment, please click on the \"Verify\" option to confirm the transaction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: const Color(0xfff566370),
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 20.0),

            Visibility(
                visible: verifyingPayment, child: CircularProgressIndicator()),

            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  // Only allow payment verification when not currently verifying
                  if (!verifyingPayment) {
                    verifyPayment();
                  }
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
                    verifyingPayment ? "Verifying..." : "Verify Payment",
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  )),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // You can optionally add a "Retry Payment" button here
            // ElevatedButton(
            //   onPressed: () {
            //     completePayment();
            //   },
            //   child: Text("Retry Payment"),
            // ),
          ],
        ),
      ),
    );
  }
}
