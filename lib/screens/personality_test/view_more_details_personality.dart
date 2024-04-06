import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talanta_new/screens/learn_more.dart';
import 'package:talanta_new/screens/news.dart';
import 'package:talanta_new/screens/payments/packages.dart';
import 'package:talanta_new/screens/personality_test/personality_test_list.dart';
import 'package:talanta_new/screens/personality_test/quiz_page.dart';
import 'package:talanta_new/screens/recommendations/career_recommendation.dart';
import 'package:talanta_new/screens/settings/settings_page.dart';
import 'package:talanta_new/utils/api_requests/ApiRequests.dart';
import 'package:talanta_new/utils/methods/AppMethods.dart';

import '../../utils/constants/AppColors.dart';

class PersonalityDetails extends StatelessWidget {
  final int position;
  PersonalityDetails({
    super.key,
    required this.position,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppMethods _appMethods = new AppMethods();

  int touchedIndex = -1; // To keep track of the selected bar.

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        AppColors.contentColorPink,
        AppColors.contentColorRed,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueAccent,
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: const Color(0xff000080),
      //   foregroundColor: Colors.white,
      //   onPressed: () {
      //     // Respond to button press
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => QuestionsScreen(),
      //     ));
      //   },
      //   icon: Icon(Icons.percent),
      //   label: Text('Take Personality Test',
      //       style: GoogleFonts.raleway(
      //           color: Colors.white,
      //           fontSize: 15,
      //           fontStyle: FontStyle.normal,
      //           fontWeight: FontWeight.w400)),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Personality Profile',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personality Profile Section
                    SizedBox(height: 10.00),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personality Profile',
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    // Bar Graph Section
                    FutureBuilder<Map<String, dynamic>>(
                      future: ApiRequests().fetchPersonalityTestResult(position),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print("${snapshot.error}");
                          return Center(
                              child: Text(
                            'Error⚠️: Unable to display chart due to a server error. Please try again later',
                            style: GoogleFonts.raleway(
                                color: Colors.red,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600),
                          ));
                        } else if (snapshot.hasData) {
                          Map<String, dynamic>? personalityData = snapshot.data;

                          List<BarChartGroupData> barGroups = [];
                          Random random = Random();

                          var test = [];

                          personalityData!.forEach((key, value) {
                            test.add(key);
                            if (key != 'id' &&
                                key != 'userid' &&
                                key != 'created_at') {
                              barGroups.add(BarChartGroupData(
                                x: barGroups.length,
                                barRods: [
                                  BarChartRodData(
                                    toY: double.parse(value.toString()),
                                    color: availableColors[random.nextInt(6)],
                                  ),
                                ],
                                showingTooltipIndicators: [0],
                              ));
                            }
                          });

                          test.remove('userid');
                          test.remove('id');
                          var createdAt = personalityData['created_at'];
                          test.remove('created_at');

                          SideTitles _bottomTitles() {
                            return SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, array) {
                                return SideTitleWidget(
                                    axisSide: array.axisSide,
                                    child: Text(
                                        test[int.parse(array.formattedValue)]
                                            .substring(0, 4)
                                            .toUpperCase(),
                                        style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)));
                              },
                            );
                          }

                          return Column(
                            children: [
                              Text(
                                'Based on the Latest Personality Test Done on $createdAt',
                                style: GoogleFonts.raleway(
                                    color: const Color(0xfff566370),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                width: double.infinity,
                                height: 300,
                                child: BarChart(
                                  BarChartData(
                                    maxY: 100,
                                    barGroups: barGroups,
                                    titlesData: FlTitlesData(
                                      show: true,
                                      leftTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: _bottomTitles(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Text('No data available.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    //       ),
    //     ],
    //   ),
    // );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildCard(String title, String icon, String description,
    Function onClick, bool isLocked) {
  return Card(
    margin: EdgeInsets.all(5),
    child: Padding(
      padding: EdgeInsets.all(1.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              if (onClick != null) {
                onClick();
              }
            },
            title: Text(
              title,
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              description,
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
            leading:
                SizedBox(height: 40, width: 40, child: Image.asset('$icon')),
            trailing:
                Icon(Icons.arrow_right_rounded, color: Colors.blue, size: 30),
          ),
          if (isLocked)
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color:
                    Colors.red, // Customize the color for the locked indicator.
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.white, size: 24),
                    SizedBox(
                        width:
                            5), // Add some spacing between the icon and text.
                    Text(
                      'Pay to View',
                      style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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

void _handleMenuButtonPressed() {
  // NOTICE: Manage Advanced Drawer state through the Controller.
  // _advancedDrawerController.value = AdvancedDrawerValue.visible();
  // _advancedDrawerController.showDrawer();
  // }
}
