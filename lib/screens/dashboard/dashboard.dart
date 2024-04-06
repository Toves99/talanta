import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class DashboardScreen extends StatelessWidget {
  bool isPaid = false;

  DashboardScreen({
    super.key,
    required this.isPaid,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppMethods _appMethods = new AppMethods();

  int touchedIndex = -1; // To keep track of the selected bar.

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        Color.fromARGB(255, 116, 97, 114),
        AppColors.contentColorRed,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xff000080),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff000080),
        foregroundColor: Colors.white,
        onPressed: () {
          // Respond to button press
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuestionsScreen(),
          ));
        },
        icon: Icon(Icons.percent),
        label: Text('Take Personality Test',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400)),
      ),
      drawer: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: ListTileTheme(
            textColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ]),
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                Text('Welcome to Talanta App',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        color: const Color(0xfff566370),
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500)),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  title: Text('Home',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionsScreen(),
                    ));
                  },
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Take a Personality Test',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                ),
                // ListTile(
                //   onTap: () async {
                //     SharedPreferences prefs =
                //         await SharedPreferences.getInstance();
                //     int? userID = prefs.getInt('userID');
                //
                //     if (isPaid) {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => RecommendedCareers(
                //             personalityId: personalityID,
                //             userID: userID,
                //           ),
                //         ),
                //       );
                //     } else {
                //       showPaymentDialog(context);
                //     }
                //   },
                //   leading: Icon(Icons.workspace_premium),
                //   title: Text('Recommended Careers For You',
                //       style: GoogleFonts.poppins(
                //           color: Colors.black,
                //           fontSize: 15,
                //           fontStyle: FontStyle.normal,
                //           fontWeight: FontWeight.w500)),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InformationPage(),
                      ),
                    );
                  },
                  leading: Icon(Icons.book_outlined),
                  title: Text('Learn more about Tests',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => PackageSelectionPage(personalityID: personalityID,),
                //       ),
                //     );
                //   },
                //   leading: Icon(Icons.payments_outlined),
                //   title: Text('Payments',
                //       style: GoogleFonts.poppins(
                //           color: Colors.black,
                //           fontSize: 15,
                //           fontStyle: FontStyle.normal,
                //           fontWeight: FontWeight.w500)),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  leading: Icon(Icons.settings),
                  title: Text('Settings',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                    IconButton(
                        onPressed: () {
                          print("Clicked");
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    Text('Hello 👋🏾',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600)),
                    const Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
                            'Your Newest Personality Profile🔥',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),

                    // Bar Graph Section
                    FutureBuilder<Map<String, dynamic>>(
                      future: ApiRequests().fetchPersonalityTestResult(0),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print("${snapshot.error}");
                          return Center(
                              child: Text(
                            'Could not load graph⚠️',
                            style: GoogleFonts.poppins(
                                color: Colors.red[300],
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600),
                          ));
                        } else if (snapshot.hasData) {
                          Map<String, dynamic>? personalityData = snapshot.data;
                          print(
                              "Personality DATA ${int.parse(personalityData?['id'])}");
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
                                    fromY: 0,
                                    toY: double.parse(value.toString()),
                                    color: availableColors[random.nextInt(6)],
                                  ),
                                ],
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
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                );
                              },
                            );
                          }

                          return Column(
                            children: [
                              Text(
                                'Based on the Latest Personality Test Done on $createdAt',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xfff566370),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 300,
                                child: BarChart(
                                  BarChartData(
                                    maxY: 100,
                                    barGroups: barGroups,
                                    gridData: FlGridData(
                                        show: true), // Hide grid lines
                                    borderData: FlBorderData(show: true),

                                    titlesData: FlTitlesData(
                                      show: true,
                                      topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false,
                                              reservedSize: 10),
                                          drawBelowEverything: false),
                                      rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false,
                                              reservedSize: 10),
                                          drawBelowEverything: false),
                                      bottomTitles: AxisTitles(
                                        sideTitles: _bottomTitles(),
                                      ),
                                    ),

                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.white,
                                      ),
                                      handleBuiltInTouches:
                                          true, // Enables built-in touch handling
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                ' For You\n',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              // View Best Careers Section

                              Column(
                                children: [
                                  FutureBuilder<bool>(
                                    future: ApiRequests().isPaid(
                                        int.parse(personalityData?['id'])),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        // If there's an error
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        // Display the result
                                        bool isPaid2 = snapshot.data!;
                                        return buildCard(
                                          'RECOMMENDATIONS',
                                          'assets/img.png',
                                          'View Top Four Best Careers that Match this Personality Profile',
                                          () async {
                                            print(
                                                "MY PSER USER ID IS $int.parse(personalityData?['id'])");

                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            var userID = prefs.getInt('userID');

                                            print("MY USER ID IS $isPaid2");

                                            if (isPaid2) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecommendedCareers(
                                                    personalityId: int.parse(
                                                        personalityData?['id']),
                                                    userID: userID,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              showPaymentDialog(
                                                  context,
                                                  int.parse(
                                                      personalityData?['id']));
                                            }
                                          },
                                          false,
                                          'https://img.huffingtonpost.com/asset/63dbff9f200000310090b533.jpeg',
                                        );
                                      }
                                    },
                                  ),
                                  buildCard('HISTORY', 'assets/history.png',
                                      'View All Personality Tests Taken',
                                      () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    int? userIDNo = prefs.getInt('userID');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalityTestList(
                                          userID: userIDNo,
                                        ),
                                      ),
                                    );
                                  }, false,
                                      'https://im.indiatimes.in/content/2023/Jun/What-Happened-this-Day-in-India-History1_647901531c022.png'),
                                  buildCard('NEWS', 'assets/news.png',
                                      'View Latest Local and Regional Career News',
                                      () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NewsPage(),
                                      ),
                                    );
                                  }, false,
                                      'https://image-processor-storage.s3.us-west-2.amazonaws.com/images/04cac9bef7d88165aeb5881a216f64d4/soldier-mother-embracing-son-and-daughter-at-home.jpg'),
                                ],
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
            'To view recommendations under this personality, payment is required.',
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

Widget buildCard(String title, String icon, String description,
    Function onClick, bool isLocked, String imageUrl) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  isLocked
                      ? Text(
                          'Pay To View',
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),

          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ), // Only show image if it's locked
        ],
      ),
    ),
  );
}

// return AdvancedDrawer(
//   backdrop: Container(
//     width: double.infinity,
//     height: double.infinity,
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Colors.white],
//       ),
//     ),
//   ),
//   controller: _advancedDrawerController,
//   animationCurve: Curves.easeInOut,
//   animationDuration: const Duration(milliseconds: 300),
//   animateChildDecoration: true,
//   rtlOpening: false,
//   // openScale: 1.0,
//   disabledGestures: false,
//   childDecoration: const BoxDecoration(
//     // NOTICE: Uncomment if you want to add shadow behind the page.
//     // Keep in mind that it may cause animation jerks.
//     // boxShadow: <BoxShadow>[
//     //   BoxShadow(
//     //     color: Colors.black12,
//     //     blurRadius: 0.0,
//     //   ),
//     // ],
//     borderRadius: const BorderRadius.all(Radius.circular(16)),
//   ),
//   drawer: SafeArea(
//     child: Container(
//       child: ListTileTheme(
//         textColor: Colors.black,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(
//               width: 128.0,
//               height: 128.0,
//               margin: const EdgeInsets.only(
//                 top: 24.0,
//                 bottom: 64.0,
//               ),
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                 color: Colors.black26,
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(
//                 'assets/logo.png',
//               ),
//             ),
//             Text('Welcome to Talanta App',
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.poppins(
//                     color: const Color(0xfff566370),
//                     fontSize: 20,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500)),
//             ListTile(
//               onTap: () {},
//               leading: Icon(Icons.home),
//               title: Text('Home',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             ListTile(
//               onTap: () {},
//               leading: Icon(Icons.account_circle_rounded),
//               title: Text('Personality Profile',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             ListTile(
//               onTap: () {
//                 if (isPaid) {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => RecommendedCareers(),
//                     ),
//                   );
//                 } else {
//                   showPaymentDialog(context);
//                 }
//               },
//               leading: Icon(Icons.workspace_premium),
//               title: Text('Recommended Careers',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const InformationPage(),
//                   ),
//                 );
//               },
//               leading: Icon(Icons.book_outlined),
//               title: Text('Learn more about Tests',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => PackageSelectionPage(),
//                   ),
//                 );
//               },
//               leading: Icon(Icons.payments_outlined),
//               title: Text('Payments',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SettingsPage(),
//                   ),
//                 );
//               },
//               leading: Icon(Icons.settings),
//               title: Text('Settings',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w500)),
//             ),
//             Spacer(),
//             DefaultTextStyle(
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 16.0,
//                 ),
//                 child: Text('Terms of Service | Privacy Policy',
//                     style: GoogleFonts.poppins(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.w500)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),
//   child: Scaffold(
//     floatingActionButton: FloatingActionButton.extended(
//       backgroundColor: const Color(0xff000080),
//       foregroundColor: Colors.white,
//       onPressed: () {
//         // Respond to button press
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => QuestionsScreen(),
//         ));
//       },
//       icon: Icon(Icons.percent),
//       label: Text('Take Personality Test',
//           style: GoogleFonts.poppins(
//               color: Colors.white,
//               fontSize: 15,
//               fontStyle: FontStyle.normal,
//               fontWeight: FontWeight.w400)),
//     ),
//     body: SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Personality Profile Section
//           SizedBox(height: 50.00),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: _handleMenuButtonPressed,
//                 icon: ValueListenableBuilder<AdvancedDrawerValue>(
//                   valueListenable: _advancedDrawerController,
//                   builder: (_, value, __) {
//                     return AnimatedSwitcher(
//                       duration: Duration(milliseconds: 250),
//                       child: Icon(
//                         value.visible ? Icons.clear : Icons.menu,
//                         key: ValueKey<bool>(value.visible),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Text('  Hello Gathua👋🏾',
//                   textAlign: TextAlign.start,
//                   style: GoogleFonts.poppins(
//                       color: const Color(0xfff566370),
//                       fontSize: 24,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w600)),
//               const Icon(Icons.notifications),
//             ],
//           ),
//           // const Padding(
//           //   padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
//           //   child: Text('  What would you like to do today?',
//           //       textAlign: TextAlign.start,
//           //       style: TextStyle(
//           //           fontSize: 16.0,
//           //           fontWeight: FontWeight.bold,
//           //           fontFamily: 'Mulish')),
//           // ),
//           Container(
//             margin: EdgeInsets.only(bottom: 20, top: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'My Most Recent Personality Profile',
//                   style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//
//           // Bar Graph Section
//           FutureBuilder<Map<String, dynamic>>(
//             future: ApiRequests().fetchPersonalityTestResult(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 print("${snapshot.error}");
//                 return Center(
//                     child: Text(
//                   'An Error occurred! Please try again later',
//                   style: GoogleFonts.poppins(
//                       color: Colors.red,
//                       fontStyle: FontStyle.normal,
//                       fontWeight: FontWeight.w600),
//                 ));
//               } else if (snapshot.hasData) {
//                 Map<String, dynamic>? personalityData = snapshot.data;
//
//                 List<BarChartGroupData> barGroups = [];
//                 Random random = Random();
//
//                 var test = [];
//
//                 personalityData!.forEach((key, value) {
//                   test.add(key);
//                   if (key != 'id' &&
//                       key != 'userid' &&
//                       key != 'created_at') {
//                     barGroups.add(BarChartGroupData(
//                       x: barGroups.length,
//                       barRods: [
//                         BarChartRodData(
//                           toY: double.parse(value.toString()),
//                           color: availableColors[random.nextInt(6)],
//                         ),
//                       ],
//                       showingTooltipIndicators: [0],
//                     ));
//                   }
//                 });
//
//                 test.remove('userid');
//                 test.remove('id');
//                 var createdAt = personalityData['created_at'];
//                 test.remove('created_at');
//
//                 SideTitles _bottomTitles() {
//                   return SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, array) {
//                       return SideTitleWidget(
//                           axisSide: array.axisSide,
//                           child: Text(
//                               test[int.parse(array.formattedValue)]
//                                   .substring(0, 4)
//                                   .toUpperCase(),
//                               style: GoogleFonts.poppins(
//                                   color: Colors.black,
//                                   fontStyle: FontStyle.italic,
//                                   fontWeight: FontWeight.w600)));
//                     },
//                   );
//                 }
//
//                 return Column(
//                   children: [
//                     Text(
//                       'Based on the Latest Personality Test Done on $createdAt',
//                       style: GoogleFonts.poppins(
//                           color: const Color(0xfff566370),
//                           fontStyle: FontStyle.normal,
//                           fontWeight: FontWeight.w400),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 300,
//                       child: BarChart(
//                         BarChartData(
//                           maxY: 100,
//                           barGroups: barGroups,
//                           titlesData: FlTitlesData(
//                             show: true,
//                             leftTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             topTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             rightTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             bottomTitles: AxisTitles(
//                               sideTitles: _bottomTitles(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Text('No data available.');
//               }
//             },
//           ),
//
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             'More Info',
//             style: GoogleFonts.poppins(
//                 color: Colors.black,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500),
//           ),
//           // View Best Careers Section
//
//           Column(
//             children: [
//               buildCard(
//                 'Recommendations',
//                 Icons.safety_divider_outlined,
//                 'View Top Four Best Careers that Match this Personality Profile',
//                 () {
//                   if (isPaid) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => RecommendedCareers(),
//                       ),
//                     );
//                   } else {
//                     showPaymentDialog(context);
//                   }
//                 },
//                 !isPaid,
//               ),
//               buildCard('View Past Tests', Icons.history,
//                   'View All Personality Tests Taken & Recommended Careers',
//                   () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => PersonalityTestList(),
//                   ),
//                 );
//               }, false),
//               buildCard('News', Icons.add_chart,
//                   'View Latest Local and Regional Career News', () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => NewsPage(),
//                   ),
//                 );
//               }, false),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// );
// }

Color _getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1.0,
  );
}

void _handleMenuButtonPressed() {
  // NOTICE: Manage Advanced Drawer state through the Controller.
  // _advancedDrawerController.value = AdvancedDrawerValue.visible();
  // _advancedDrawerController.showDrawer();
  // }
}
