import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/user/sign_up.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_back_button.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:talanta_new/utils/widgets/text/custom_text.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final AppColors _appColors = AppColors();
  final AppTextStyle _appTextStyle = AppTextStyle();
  ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
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
                        const Spacer(),
                        Container(
                          child: AppTextStyle().customizableTex(
                              'Forgot Password',
                              Colors.black,
                              FontWeight.w500,
                              24),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Center(
                      child: Image.asset(
                        'assets/forgot_password.png',
                        width: 200, // Adjust the size
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _appTextStyle.customizableTex('Forgot your password!',
                        Colors.black, FontWeight.w600, 28.0),
                    _appTextStyle.customizableTex(
                        'Enter your email address below to reset your password.',
                        Colors.black,
                        FontWeight.w400,
                        18.0),
                    const SizedBox(height: 10.0),
                    FormBuilderTextField(
                      name: 'email',
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
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: CustomElevatedButton(
                        width: MediaQuery.of(context).size.width,
                        buttonLabel: AppTextStyle().customizableTex(
                            'Reset', _appColors.white, FontWeight.w500, 16),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // get text from form fields
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
