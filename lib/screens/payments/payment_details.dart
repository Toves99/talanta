import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/payments/confirm_payment.dart';

class PaymentPage extends StatefulWidget {
  final String phoneNumber; // Replace with the actual MPESA number
  final double amount;

  const PaymentPage(
      {super.key,
      required this.phoneNumber,
      required this.amount}); // Replace with the actual payment amount

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
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
                Text('Payment Details',
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
            Center(
              child: Image.asset(
                'assets/payment_detail.png',
                width: 200, // Adjust the size
                height: 200,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'You are about to make a one-time payment of :-',
              style: GoogleFonts.raleway(
                  color: const Color(0xfff566370),
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'KES ${widget.amount} via MPESA number ${widget.phoneNumber}.',
              style: GoogleFonts.raleway(
                  color: const Color(0xfff566370),
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement the "Proceed to Pay" functionality
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => PaymentVerificationPage(),
                    //   ),
                    // );
                  },
                  child: Text('Proceed to Pay'),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    // Implement the "Cancel" functionality
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
