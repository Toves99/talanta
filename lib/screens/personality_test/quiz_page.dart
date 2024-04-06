import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/dashboard/dashboard.dart';
import 'package:talanta_new/screens/personality_test/success_personality_test.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/api_requests/ApiRequests.dart';
import 'package:talanta_new/utils/constants/AppColors.dart';
import 'package:talanta_new/utils/models/QuizCategory.dart';
import 'package:http/http.dart' as http;
import 'package:talanta_new/utils/widgets/buttons/Custom_Dialog.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final PageController _pageController = PageController();
  Map<String, QuizCategory>? _quizData;
  int _currentPage = 0;
  ApiRequests _apiRequests = ApiRequests();
  var options = ['Yes', 'No'];

  // Initialize a map to store responses
  Map<String, Map<String, dynamic>> categoryResponses = {};

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    // Fetch quiz data using fetchQuizData and set it to _quizData.
    _quizData = await _apiRequests.fetchQuizData();
    setState(() {});
  }

  void _nextPage() {
    if (_currentPage < (_quizData?.length ?? 0) - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        _currentPage++;
      });
    }
  }

  _viewResultOrRetakeTest(BuildContext context) {
    // Implement logic to either view results or retake the test.

    print("I GOT HERE");
    if (_currentPage == (_quizData?.length ?? 0) - 1) {
      // Save responses to shared preferences
      _saveResponsesToSharedPreferences(context);
      //  let's navigate to the DashboardScreen.
    }
  }

  // Function to update the responses map
  void _updateResponses(String category, String response) {
    if (categoryResponses != null) {
      final categoryMap =
          categoryResponses[category] ?? <String, dynamic>{"Yes": 0, "No": 0};

      if (response == "Yes") {
        categoryMap["Yes"] = (categoryMap["Yes"] ?? 0) + 1;
      } else if (response == "No") {
        categoryMap["No"] = (categoryMap["No"] ?? 0) + 1;
      }

      categoryResponses[category] = categoryMap;
    }
  }

  void _saveResponsesToSharedPreferences(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();
    progressDialog.show(context);

    // Retrieve the user ID from shared preferences
    int? userID = prefs.getInt("userID");
    if (userID != null) {
      print("USER ID $userID");
      var newJSON = {
        'pid': userID,
        "enterprising":
            ((categoryResponses['enterprisingquiz']!['Yes'] / 18) * 100).ceil(),
        "realistic":
            ((categoryResponses['realisticquiz']!['Yes'] / 18) * 100).ceil(),
        "conventional":
            ((categoryResponses['conventionalquiz']!['Yes'] / 18) * 100).ceil(),
        "social": ((categoryResponses['socialquiz']!['Yes'] / 18) * 100).ceil(),
        "artistic":
            ((categoryResponses['artisticquiz']!['Yes'] / 18) * 100).ceil(),
        "investigative":
            ((categoryResponses['investigativequiz']!['Yes'] / 18) * 100).ceil()
      };
      print("NEW JSON $newJSON");
      String jsonString = jsonEncode(newJSON);
      await prefs.setString("responses", jsonString);
      // Make a POST request to the API
      final response = await http.post(
        Uri.parse(APIEndpoints.savePersonality), // Replace with your API URL
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      if (response.statusCode == 200) {
        progressDialog.hide();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                ThankYouPage(title: 'Personality Test Completed'),
          ),
          (route) => false, // Remove all routes from the stack
        );
      } else {
        // Handle the case of an unsuccessful response (if needed)
        progressDialog.hide();
        showErrorDialog(context, 'Failed to save responses to the server');
        print('Failed to save responses to the server');
      }
    } else {
      progressDialog.hide();
      showErrorDialog(context, 'User ID/Personality ID not found');
      print('User ID not found in shared preferences');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unable to submit your personality test',
              style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 17,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500)),
          content: Text(
              'We encountered an error when trying to submit your personality test:\n$message',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500)),
          actions: <Widget>[
            TextButton(
              child: Text('Go to Dashboard',
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(isPaid: true),
                  ),
                  (route) => false, // Remove all routes from the stack
                );
              },
            ),
            TextButton(
              child: Text('Try again',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _quizData == null
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              itemCount: _quizData!.length,
              itemBuilder: (context, index) {
                final category = _quizData!.keys.elementAt(index);
                final questions = _quizData![category]!.questions;
                return _buildCategoryPage(category, questions);
              },
            ),
      floatingActionButton: _currentPage < (_quizData?.length ?? 0) - 1
          ? FloatingActionButton(
              onPressed: () {
                // Update responses when the user selects an option
                final selectedOption = "Yes"; // Replace with selected option
                final currentCategory = _quizData!.keys.elementAt(_currentPage);
                _updateResponses(currentCategory, selectedOption);
                _nextPage();
              },
              child: Icon(Icons.arrow_forward),
            )
          : ElevatedButton(
              onPressed: () {
                _viewResultOrRetakeTest(context);
              },
              child: Text("Submit"),
            ),
    );
  }

  Widget _buildCategoryPage(String category, Map<int, String> questions) {
    if (_quizData == null) {
      return Center(child: CircularProgressIndicator());
    }
    final categoryData = _quizData![category];
    if (categoryData == null) {
      return Text('Category not found');
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Text('Personality Test Page ${_currentPage + 1}/6',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: questions.length - 1,
            itemBuilder: (context, index) {
              final ite = questions.keys.toList();
              final question = questions[ite[index + 1]];
              if (question != null) {
                return ListTile(
                  title: FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: question,
                      labelText: question,
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
                            width: 1, color: AppColors().secondaryColor),
                      ),
                    ),
                    name: 'my_language',
                    validator: FormBuilderValidators.required(),
                    options: ['Yes', 'No']
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                    onChanged: (value) {
                      // Update responses when an option is selected
                      _updateResponses(category, value!);
                    },
                  ),
                );
              } else {
                // Handle the case where the question is null.
                return Text('Error');
              }
            },
          )
        ],
      ),
    );
  }
}
