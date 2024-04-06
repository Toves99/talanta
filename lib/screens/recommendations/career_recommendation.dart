import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:talanta_new/screens/dashboard/new_user.dart';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';

import '../dashboard/dashboard.dart';
import 'career_details.dart';

class TestAction {
  final String title;
  final DateTime date;
  final String code;
  final String occupationID;

  TestAction(this.title, this.date, this.code, this.occupationID);
}

class RecommendedCareers extends StatelessWidget {
  final int? personalityId;
  final int? userID;
  const RecommendedCareers(
      {super.key, required this.personalityId, required this.userID});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<List<TestAction>>(
          future: generateTestActions(userID!, personalityId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print("NENO ${snapshot.stackTrace}");
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<TestAction> testActions = snapshot.data ?? [];

              if (testActions.length > 0) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            'View Recommended Careers',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              color: const Color(0xfff566370),
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(
                                    isPaid: true,
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                            icon: Icon(Icons.home),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 5.0, right: 5.0, top: 7.0),
                        child: Text(
                          'Best Recommended Careers for Me Based My Personality',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: testActions.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              leading: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 7.0),
                                child: CircleAvatar(
                                  backgroundColor: _getRandomColor(),
                                  radius: 28,
                                  child: Text(
                                    _getInitials(testActions[index].title),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                testActions[index].title,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text(
                                    'Pers Cluster Code: ${testActions[index].code}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CareerDetailsPage(
                                            userID: userID!,
                                            id: personalityId!,
                                            occupationName:
                                                testActions[index].title,
                                            occId: int.parse(testActions[index]
                                                .occupationID),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'View More',
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text('No Data Found'),
              );
            }
          },
        ),
      ),
    );
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  String _getInitials(String fullName) {

    print("FULL N $fullName");
    List<String> names = fullName.replaceAll(RegExp(r'[^a-zA-Z]'), '').split("");


    print("FULL N 2$names");

    String initials = "";

    if (names.isNotEmpty) {
      initials += names[0][0];
      if (names.length > 1) {
        initials += names.last[0];
      }
    }
    return initials.toUpperCase();
  }
}

// Inside RecommendedCareers class
Future<List<TestAction>> generateTestActions(
    int userID, int personalityID) async {
  try {
    var requestBody = {"personalityId": personalityID, 'limit': 5};

    final response = await http.post(
      Uri.parse('${APIEndpoints.baseUrl}/personality/test/getRecommendations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final recommendations =
          responseBody['data']['userpersonalityrecommendedoccupationsview'];
      print(
          'RECOMEND ${responseBody['data']['userpersonalityrecommendedoccupationsview']}');
      List<TestAction> actions = [];
      for (var recommendation in recommendations) {
        actions.add(TestAction(
            recommendation['title'],
            DateTime.parse(recommendation['createddatetime']),
            recommendation['persclustercode'],
            recommendation['occupationid']));
      }
      return actions;
    } else {
      print('Failed to load recommendations ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Exception during API call: $error');
    return [];
  }
}
