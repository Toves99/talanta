// SPLASH SCREEN CODE
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/user/sign_in.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:talanta_new/utils/widgets/text/custom_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // VendorHomePage
          builder: (context) => GetStartedScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.contentColorBlue,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset('assets/talanta_logo.png'),
        ),
      ),
    );
  }
}

class GetStartedScreen extends StatelessWidget {
  static const Color contentColorBlue = Color(0xFF004AAD);
  static const double backgroundImageOpacity = 0.7; // Adjust opacity as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.indigo
                  .withOpacity(0.9), // Adjust the opacity and color as needed
              BlendMode
                  .overlay, // You can try different blend modes for different effects
            ),
            child: Image.asset(
              'assets/bg.jpg', // Replace with your actual image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
          ),
          // Foreground Content
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text at the forefront
                Spacer(),
                Text(
                  'Welcome to Talanta!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 48,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Center(
                  child: Text(
                    'Discover Your Occupation!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Identify your ideal occupation by completing a personality assessment and receiving tailored recommendations based on your personality traits.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                // Spacer
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: CustomElevatedButton(
                      width: MediaQuery.of(context).size.width,
                      buttonLabel: AppTextStyle().customizableTex(
                          'Get Started', Colors.white, FontWeight.w500, 16),
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
