import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanta_new/screens/dashboard/new_user.dart';
import 'package:talanta_new/screens/payments/confirm_payment.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:http/http.dart' as http;

import '../dashboard/dashboard.dart';

class AddPaymentPhoneNumberPage extends StatefulWidget {
  final int amount;
  final int personalityID;

  const AddPaymentPhoneNumberPage({
    super.key,
    required this.amount,
    required this.personalityID,
  });
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<AddPaymentPhoneNumberPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  var userMessage = '';
  bool showNotification = false;
  bool showModal = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('Payment',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.raleway(
                          color: const Color(0xfff566370),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(
                                    isPaid: true,
                                  )),
                        );
                      },
                      icon: Icon(Icons.home)),
                ],
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text("PAY AS YOU GO PACKAGE",
                              style: GoogleFonts.raleway(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //Center Row contents vertically,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text("KES ",
                                  style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text('100',
                                  style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                      Text(
                          'Enter your M-PESA Phone Number below and click Process Payment, then check your mobile phone handset for an instant payment request from M-PESA',
                          style: GoogleFonts.raleway(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300)),
                      SizedBox(height: 30),
                      FormBuilder(
                        key: _formKey,
                        child: FormBuilderTextField(
                          name: 'phone',
                          controller: phoneNumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.phone,
                            ),
                            hintText: '7XXXXXXXX or 1XXXXXXXX',
                            labelText: 'Enter MPESA Phone Number',
                            hintStyle: GoogleFonts.raleway(
                                color: const Color(0xfff566370),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                            labelStyle: GoogleFonts.raleway(
                                color: const Color(0xfff566370),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors().secondaryColor),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(9,
                                errorText:
                                    'Correct phone number format is 7XXXXXXXX'),
                            FormBuilderValidators.minLength(9,
                                errorText:
                                    'Correct phone number format is 7XXXXXXXX'),
                          ]),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(height: 200),
                      Visibility(
                          visible: showNotification,
                          child: Column(
                            children: [
                              showModal
                                  ? CircularProgressIndicator()
                                  : Container(),
                              Text('$userMessage',
                                  style: GoogleFonts.raleway(
                                      color:
                                          isError ? Colors.red : Colors.green,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300)),
                            ],
                          )),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            var phoneNumber =
                                phoneNumberController.value.text.trim();
                            makePostRequest(int.parse('254$phoneNumber'),
                                widget.amount, widget.personalityID);
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
                            'Process Payment',
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
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  ///Initiate StK
  Future<void> makePostRequest(phoneNumber, amount, personality) async {
    showModal = true;
    showNotification = true;
    userMessage = 'Please wait while we process your payment!';
    setState(() {});
    const String apiUrl =
        APIEndpoints.initiateSTK; // Replace with your API endpoint

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getInt('userID');

    Map<String, dynamic> requestBody = {
      "mobile": phoneNumber,
      "amount": 1,
      "userId": userId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showModal = false;
        isError = false;
        // Successful response
        userMessage = responseData['data']['CustomerMessage'] +
            '\nPlease enter your pin to confirm payment';
        setState(() {});
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentVerificationPage(
              checkoutRequestID: responseData['data']['CheckoutRequestID'],
              personalityID: widget.personalityID.toString(),
            ),
          ),
        );

        // Show the customer message
      } else {
        // Error response
        showModal = false;
        isError = true;
        userMessage = '${responseData['data']['error']}';
        setState(() {});
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (error) {
      userMessage = '$error';
      isError = true;
      setState(() {});
    }
  }
}
