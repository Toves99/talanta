import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/user/awaiting_verify.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_back_button.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:talanta_new/utils/widgets/text/custom_text.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  AppColors _appColors = AppColors();
  AppTextStyle _appTextStyle = AppTextStyle();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGender;
  bool showProgress = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<bool> signUp(
      String email,
      String phone,
      String password,
      String firstName,
      String lastName,
      String dob,
      String gender,
      bool rememberMe) async {
    final Map<String, dynamic> requestBody = {
      "method": "custom_email",
      "email": email,
      "mobile": phone,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "dob": dob,
      "gender": gender,
      "rememberMe": rememberMe,
    };

    try {
      final response = await http.post(
        Uri.parse(APIEndpoints
            .signupEndpoint), // Replace with your actual API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print("JSON ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green, // You can use a custom color.
        ));
        // User registration successful, you may handle success logic here.
        return true;
      } else {
        // Registration failed, handle the error response from the API.
        // You can show an error message based on the response data.
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String errorMessage = responseData['message']['error'];
        // Show the error message to the user or handle it in your preferred way.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red, // You can use a custom color.
        ));

        showProgress = false;
        setState(() {});
        return false;
      }
    } catch (exception) {
      // Handle network or other exceptions.
      showProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
        backgroundColor: Colors.red, // You can use a custom color.
      ));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1.5,
            padding: const EdgeInsets.all(20.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30.0),
                  Row(
                    children: [
                      // back button
                      Container(
                        child: CustomBackButton(
                          iconColor: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: AppTextStyle().customizableTex(
                            'Register', Colors.black, FontWeight.w500, 24),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  _appTextStyle.customizableTex(
                      "Get started on your journey with Talanta!",
                      Colors.black,
                      FontWeight.w600,
                      28.0),
                  _appTextStyle.customizableTex('Please sign up to continue',
                      Colors.black, FontWeight.w400, 18.0),
                  const SizedBox(height: 10.0),
                  FormBuilderTextField(
                    name: 'firstName',
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.account_circle_outlined,
                      ),
                      hintText: 'First Name',
                      labelText: 'First Name',
                      hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderTextField(
                    name: 'lastName',
                    controller: _lastNameController,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                      prefixIcon: const Icon(
                        Icons.account_circle_outlined,
                      ),
                      hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderDropdown(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Highest Level Of Education',
                      labelText: 'Highest Level Of Education',
                      hintStyle: GoogleFonts.raleway(
                        fontSize: 14,
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: GoogleFonts.raleway(
                        color: const Color(0xfff566370),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: _appColors.secondaryColor,
                        ),
                      ),
                    ),
                    name: 'education_dropdown',
                    validator: FormBuilderValidators.required(),
                    items: [
                      'Postdoctoral Studies',
                      'Professional Degree ',
                      'Doctorate/Ph.D',
                      'Master\'s Degree',
                      'Bachelor\'s Degree',
                      'Diploma',
                      'Certificate',
                      'Vocational/Technical Training',
                      'High School',
                      'Primary School',
                      'No Formal Education'
                    ]
                        .map((lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(lang),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith(' '),
                    ),
                    items: [
                      'Software Developer',
                      'Teacher',
                      'Doctor',
                      'Engineer',
                      'Graphic Designer',
                      'Accountant',
                      'Nurse',
                      'Chef',
                      'Police Officer',
                      'Writer',
                      'Marketing Manager',
                      'Electrician',
                      'Data Analyst',
                      'Mechanic',
                      'Architect',
                      'Social Worker',
                      'Pilot',
                      'Financial Advisor',
                      'Dentist',
                      'Photographer',
                      'Entrepreneur',
                      'Librarian',
                      'Psychologist',
                      'Pharmacist',
                      'Lawyer',
                      'Plumber',
                      'Artist',
                      'Human Resources Manager',
                      'Biologist',
                      'Veterinarian',
                      'Event Planner',
                      'Translator',
                      'Fitness Trainer',
                      'Meteorologist',
                      'Real Estate Agent',
                      'Construction Worker',
                      'Flight Attendant',
                      'Public Relations Specialist',
                      'Research Scientist',
                      'Speech Therapist',
                      'Interior Designer',
                      'Geologist',
                      'Paramedic',
                      'Animator',
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        hintText: 'Current Occupation',
                        labelText: 'Current Occupation',
                        hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
                          color: const Color(0xfff566370),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: GoogleFonts.raleway(
                          color: const Color(0xfff566370),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: _appColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    onChanged: print,
                    selectedItem: "",
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderDateTimePicker(
                    name: 'dateOfBirth',
                    controller: _dateOfBirthController,
                    textInputAction: TextInputAction.next,
                    inputType: InputType.date,
                    initialDate: DateTime.now()
                        .subtract(const Duration(days: (365 * 18))),
                    lastDate: DateTime.now()
                        .subtract(const Duration(days: (365 * 18))),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.calendar_month,
                      ),
                      hintText: 'Date of Birth',
                      labelText: 'Date of Birth',
                      hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderRadioGroup(
                    onChanged: (value) {
                      _selectedGender = value!;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Gender',
                      labelText: 'Gender',
                      hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                    name: 'gender',
                    validator: FormBuilderValidators.required(),
                    options: [
                      'Male',
                      'Female',
                      'Prefer not to say',
                    ]
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderTextField(
                    name: 'email',
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      hintText: 'Email Address',
                      labelText: 'Email Address',
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 10.0),
                  FormBuilderTextField(
                    name: 'phone',
                    controller: _phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(10,
                          errorText: 'Invalid Phone Number'),
                      FormBuilderValidators.minLength(10,
                          errorText: 'Invalid Phone Number'),
                    ]),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                      hintStyle: GoogleFonts.raleway(
                          fontSize: 14,
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
                            width: 1, color: _appColors.secondaryColor),
                      ),
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6,
                          errorText: 'Password too short!'),
                    ]),
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
                          'Register Account',
                          _appColors.white,
                          FontWeight.w500,
                          16),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Get values from controllers
                          showProgress = true;
                          setState(() {});
                          final firstName = _firstNameController.text;
                          final lastName = _lastNameController.text;
                          final email = _emailController.text;
                          final phone =
                              '+254' + _phoneController.text.substring(1);
                          final password = _passwordController.text;
                          final dob = _dateOfBirthController.text;
                          final gender = _selectedGender ?? '';
                          final rememberMe =
                              false; // Replace with your logic for 'remember me'.

                          // Make the API request
                          final registrationResult = await signUp(
                            email,
                            phone,
                            password,
                            firstName,
                            lastName,
                            dob,
                            gender,
                            rememberMe,
                          );

                          if (registrationResult) {
                            // Registration was successful, navigate to the next screen.
                            // You can replace this with your navigation logic.
                            showProgress = false;
                            setState(() {});
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return EmailVerifyPage(
                                  emailAddress: email,
                                ); // Replace with the screen you want to navigate to.
                              },
                            ));
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: GoogleFonts.poppins(
                              color: const Color(0xfff566370),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            const TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: GoogleFonts.poppins(
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
        ],
      ),
    ));
  }
}
