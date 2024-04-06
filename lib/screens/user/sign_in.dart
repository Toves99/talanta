import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';
import 'package:talanta_new/screens/payments/packages.dart';
import 'package:talanta_new/screens/user/forgot_password.dart';
import 'package:talanta_new/screens/user/sign_up.dart';
import 'package:talanta_new/utils/api_requests/ApiRequests.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:talanta_new/utils/widgets/text/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final AppColors _appColors = AppColors();
  final AppTextStyle _appTextStyle = AppTextStyle();
  final ApiRequests _apiRequests = ApiRequests();
  //utils
  bool showProgress = false;

  //Controllers
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      child: AppTextStyle().customizableTex(
                          'Welcome To Talanta',
                          AppColors.contentColorBlue,
                          FontWeight.w700,
                          30),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: Image.asset(
                    'assets/login_pic.png',
                    width: MediaQuery.of(context).size.width *
                        0.7, // Adjust the size
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                SizedBox(height: 30.0),
                _appTextStyle.customizableTex('Let\'s get started now!',
                    Colors.black, FontWeight.w600, 28.0),
                _appTextStyle.customizableTex('Please sign in to continue',
                    Colors.black, FontWeight.w400, 18.0),
                SizedBox(height: 10.0),
                FormBuilderTextField(
                  name: 'email',
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email,
                    ),
                    hintText: 'Email Address',
                    labelText: 'Email Address',
                    hintStyle: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    labelStyle: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color: _appColors.secondaryColor),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_rounded,
                    ),
                    hintText: 'Password',
                    labelText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    labelStyle: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color: _appColors.secondaryColor),
                    ),
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Forgot password',
                        style: GoogleFonts.poppins(
                            color: AppColors.contentColorBlue,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                          'Login', _appColors.white, FontWeight.w500, 16),
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          showProgress = true;
                          setState(() {});

                          final email = emailController.value.text;
                          final password = passwordController.value.text;

                          final authToken =
                              await _apiRequests.authenticateAndSaveToken(
                            email,
                            password,
                          );

                          if (authToken?['token'] != null) {
                            showProgress = false;
                            setState(() {});

                           /*Fluttertoast.showToast(
                              msg: "Login Successful!",
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );**/

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DashboardScreen(isPaid: false),
                              ),
                            );
                          } else {
                            showProgress = false;
                            setState(() {});
                            showErrorDialog(context, authToken?['message']);
                          }
                        } else {
                          showProgress = false;
                          setState(() {});
                          showErrorDialog(
                              context, 'Username and password cannot be Empty');
                        }
                      }),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FutureBuilder<PackageInfo>(
                      future: _getPackageInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          String buildNumber = snapshot.data!.version;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Build Number:  $buildNumber -Dev',
                                style: GoogleFonts.raleway(
                                    color: AppColors.contentColorBlue,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: GoogleFonts.raleway(
                            color: const Color(0xfff566370),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: GoogleFonts.raleway(
                                color: AppColors.contentColorBlue,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showErrorDialog(BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
