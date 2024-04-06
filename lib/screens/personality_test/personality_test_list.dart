import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:talanta_new/screens/payments/packages.dart';
import 'package:talanta_new/screens/personality_test/quiz_page.dart';
import 'package:talanta_new/screens/personality_test/view_more_details_personality.dart';
import 'package:talanta_new/screens/recommendations/career_recommendation.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/api_requests/ApiRequests.dart';

import '../../utils/widgets/buttons/Custom_Dialog.dart';

class TestAction {
  final String userID;
  final DateTime date;
  final Map<String, String> scores;

  TestAction(this.userID, this.date, this.scores);
}

class PersonalityTestList extends StatefulWidget {
  final int? userID;

  const PersonalityTestList({super.key, required this.userID});
  @override
  _PersonalityTestListState createState() => _PersonalityTestListState();
}

class _PersonalityTestListState extends State<PersonalityTestList> {
  List<TestAction> testActions = [];
  bool showProgDialog = false;
  bool showError = false;
  var errorMessage = '';

  @override
  void initState() {
    super.initState();
    showProgDialog = true;
    setState(() {});
    fetchTestActions(widget.userID);
  }

  void showPaymentDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment is Required',
              style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 17,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500)),
          content: Text(
              'To access recommendations under this personality, payment is required.',
              style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500)),
          actions: <Widget>[
            TextButton(
              child: Text('Pay Now',
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PackageSelectionPage(
                      personalityID: id,
                    ),
                  ),
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
  }

  Future<void> fetchTestActions(int? userID) async {
    final response = await http.post(
      Uri.parse(APIEndpoints.retrievePersonality),
      body: json.encode({"pid": userID, "limit": 0}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      showProgDialog = false;
      showError = false;
      setState(() {});
      final data = json.decode(response.body);

      print("OUR DATA is $data");

      setState(() {
        testActions = (data['data']['userpersonality'] as List)
            .map((item) => TestAction(
                  item['id'],
                  DateTime.parse(item['created_at']),
                  {
                    'conventional': item['conventional'],
                    'artistic': item['artistic'],
                    'investigative': item['investigative'],
                    'enterprising': item['enterprising'],
                    'social': item['social'],
                    'realistic': item['realistic'],
                  },
                ))
            .toList();
      });
    } else {
      // Handle error
      showProgDialog = false;
      showError = true;
      errorMessage = 'Failed to fetch data';
      setState(() {});
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                    icon: Icon(Icons.arrow_back_sharp),
                  ),
                  Spacer(),
                  Text(
                    'View All Personality Tests',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      color: const Color(0xfff566370),
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer()
                ],
              ),
              Visibility(visible: showError, child: Text(errorMessage)),
              Visibility(
                  visible: showProgDialog, child: CircularProgressIndicator()),
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Make it not scrollable
                itemCount: testActions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: (index == 0)
                          ? Text(' ☆My Most Recent Personality ☆',
                              style: GoogleFonts.poppins(
                                  color: Colors.indigo,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500))
                          : Text('Personality Test ${index + 1}',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xfff566370),
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Done on: ' +
                                    DateFormat.yMMMd()
                                        .format(testActions[index].date),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xfff566370),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400)),
                            Text(
                                'At: ' +
                                    formatTimeString(
                                        testActions[index].date.toString()),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xfff566370),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300)),
                          ]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () async {
                              CustomProgressDialog progressDialog =
                                  CustomProgressDialog();
                              progressDialog.show(context);

                              bool checker = await ApiRequests()
                                  .isPaid(int.parse(testActions[index].userID));

                              print("MANEOSNONR $checker");
                              if (checker) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var userID = prefs.getInt('userID');

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecommendedCareers(
                                      personalityId:
                                          int.parse(testActions[index].userID),
                                      userID: userID,
                                    ),
                                  ),
                                );
                                progressDialog.hide();
                              } else {
                                progressDialog.hide();
                                showPaymentDialog(context,
                                    int.parse(testActions[index].userID));
                              }
                            },
                            child: Text('View More',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTimeString(String inputString) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(inputString);

    // Format the DateTime object to display the time in HH:mm format
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    // Determine whether it's AM or PM
    String period = dateTime.hour < 12 ? 'AM' : 'PM';

    // Return the formatted time with AM/PM
    return "$formattedTime$period";
  }
}
