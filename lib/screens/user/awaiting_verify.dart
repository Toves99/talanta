import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talanta_new/screens/user/sign_in.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/api_requests/ApiRequests.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:talanta_new/utils/widgets/text/custom_text.dart';

class EmailVerifyPage extends StatefulWidget {
  final String emailAddress;
  const EmailVerifyPage({Key? key, required this.emailAddress})
      : super(key: key);

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final AppColors _appColors = AppColors();
  final AppTextStyle _appTextStyle = AppTextStyle();
  final ApiRequests _apiRequests = ApiRequests();
  //utils
  bool showProgress = false;

  // Function to make the API call
  Future<void> verifyEmail() async {
    showProgress = true;
    setState(() {});
    // Prepare the request body
    var email = widget.emailAddress;
    final Map<String, String> data = {
      "email": email,
    };

    // Send a POST request to the API
    final response = await http.post(Uri.parse(APIEndpoints.verifyEmail),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // If the API call is successful
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        // Email is already verified
        showProgress = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['data']),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else if (response.statusCode == 403) {
      // If the API call fails with a 403 error
      final responseBody = json.decode(response.body);
      String errorMessage = responseBody['data']['error'];
      showProgress = false;
      setState(() {});
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else if (response.statusCode == 203) {
      showProgress = false;
      setState(() {});
      // If the API call fails with a 403 error
      final responseBody = json.decode(response.body);
      String errorMessage = responseBody['data']['error'];
      showProgress = false;
      setState(() {});
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      showProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Server Error: ${response.statusCode}, Try again later'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Prevent going backward
          return false;
        },
        child: Scaffold(
            resizeToAvoidBottomInset:
                false, // Prevent the scaffold from resizing
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(20.0),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30.0),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                child: AppTextStyle().customizableTex(
                                    'Verification',
                                    Colors.black,
                                    FontWeight.w500,
                                    30),
                              ),
                              Spacer(),
                            ],
                          ),
                          Center(
                            child: Image.asset(
                              'assets/login_pic.png',
                              width: 200, // Adjust the size
                              height: 200,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          _appTextStyle.customizableTex(
                              'Verify your email address',
                              Colors.black,
                              FontWeight.w600,
                              28.0),
                          _appTextStyle.customizableTex(
                              'Thank you for signing up with Talanta! To complete your registration, please click the link sent to your email address to verify your email.',
                              Colors.black,
                              FontWeight.w400,
                              18.0),
                          SizedBox(height: 10.0),
                          showProgress
                              ? Center(
                                  child: Container(
                                      child: CircularProgressIndicator(
                                          color: _appColors.primaryColor)))
                              : Container(),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: CustomElevatedButton(
                              width: MediaQuery.of(context).size.width,
                              buttonLabel: AppTextStyle().customizableTex(
                                  'Confirm',
                                  _appColors.white,
                                  FontWeight.w500,
                                  16),
                              onPressed: verifyEmail,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
