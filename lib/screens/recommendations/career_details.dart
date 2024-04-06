import 'dart:convert';
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';

import '../../utils/constants/AppColors.dart';

class CareerDetailsPage extends StatefulWidget {
  final int id;
  final int userID;
  final int occId;
  final String occupationName;

  const CareerDetailsPage(
      {Key? key,
      required this.id,
      required this.userID,
      required this.occId,
      required this.occupationName})
      : super(key: key);

  @override
  State<CareerDetailsPage> createState() => _CareerDetailPageState();
}

class _CareerDetailPageState extends State<CareerDetailsPage> {
  Color circleColor = Colors.blue;

  final List<Color> availableColors = [
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> fetchData(
      int userID, int personalityID, int occupationID) async {
    var headers = {
      'userid': '$userID',
      'personalityid': '$personalityID',
      'occupationid': '$occupationID',
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST',
        Uri.parse('${APIEndpoints.josdapURL}/talanta2/talanta.api.josdap'));
    request.body = json.encode({
      "object": "userpersonalityoccupationdetails",
      "command": "select",
      "id": 0,
      "fields": "*",
      "conditions": "",
      "limit": 10,
      "returnchildobjects": 0,
      "childobjectsfilter": [],
      "sortfield": "",
      "sortcriteria": ""
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("CAREER DETAIL OBJECT RESPONSE ${response.stream}");
      return json.decode(await response.stream.bytesToString());
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchRecommendedCourseData(
      int occupationID) async {
    // var headers = {
    //   'userid': '$userID',
    //   'personalityid': '$personalityID',
    //   'occupationid': '$occupationID',
    //   'Content-Type': 'application/json'
    // };

    var request = http.Request('POST',
        Uri.parse('${APIEndpoints.josdapURL}/talanta2/talanta.api.josdap'));
    request.body = json.encode({
      "object": "occupationcoursesview",
      "command": "select",
      "id": 0,
      "fields": "*",
      "conditions": 'occupationid=$occupationID',
      "limit": 10,
      "returnchildobjects": 0,
      "childobjectsfilter": [],
      "sortfield": "",
      "sortcriteria": ""
    });
    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("CAREER DETAIL OBJECT RESPONSE ${response.stream}");
      return json.decode(await response.stream.bytesToString());
    } else {
      throw Exception('Failed to load data');
    }
  }

  Color getColorBasedOnCriticality(double criticalityValue) {
    if (criticalityValue >= 70.0) {
      return Colors.green[900] ?? Colors.green;
    } else if (criticalityValue >= 60.0) {
      return Colors.green[400] ?? Colors.green;
    } else {
      return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: fetchData(widget.userID, widget.id, widget.occId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var responseData = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            icon: Icon(Icons.arrow_back_sharp)),
                        Spacer(),
                        Text('Career Details',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: const Color(0xfff566370),
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.home)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: _getRandomColor(),
                            radius: 40,
                            child: Text(
                              _getInitials(widget.occupationName),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            widget.occupationName,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            'Career Summary',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          responseData?['occupationdetails']['description'],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text(
                        'Personality Profile',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Personality Profile Required for Software Engineers vs My Latest Personality Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                    BarChartSample2(
                      occupationName: widget.occupationName,
                      careerPersonality: responseData?['occupationdetails']
                          ['personality'],
                      userPersonality: responseData?['userpersonality'],
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    ExpandablePanel(
                      header: Text(
                        'Recommeded Courses',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      collapsed: Container(),
                      expanded: responseData?['occupationdetails']['courses']
                                  .length >
                              0
                          ? ListView.builder(
                              physics:
                                  NeverScrollableScrollPhysics(), // Make it not scrollable

                              itemCount: responseData?['occupationdetails']
                                      ['courses']
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var course = responseData?['occupationdetails']
                                    ['courses'][index];
                                print("Building list item for course: $course");

                                return ListTile(
                                  title: Row(
                                    children: [
                                      // Display initials based on course name
                                      CircleAvatar(
                                        backgroundColor: Colors
                                            .blue, // You can set a different color if needed
                                        child: Text(
                                          _getInitials(
                                              course['coursename'] ?? ""),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Add spacing between avatar and text
                                      Column(
                                        // Wrap the course name and description in a Column
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:20),
                                            child: Text(course['coursename'] ?? "",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                )),
                                          ),
                                              
                                          Text(
                                              course['coursedescription'] ?? "",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: Container(
                                              color: getColorBasedOnCriticality(
                                                  double.parse(course[
                                                          'criticalityvalue'] ??
                                                      "0"))))
                                    ],
                                  ),
                                );
                              },
                            )
                          : Text('No data found',
                              style: GoogleFonts.poppins(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              )),
                    ),
                    SizedBox(height: 20),
                    ExpandablePanel(
                      header: Text(
                        'Subjects Required',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      collapsed: Container(),
                      expanded: responseData?['occupationdetails']['subjects']
                                  .length >
                              0
                          ? ListView.builder(
                              physics:
                                  NeverScrollableScrollPhysics(), // Make it not scrollable
                              itemCount: responseData?['occupationdetails']
                                      ['subjects']
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var subject = responseData?['occupationdetails']
                                    ['subjects'][index];

                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text(subject['subjectname'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      Spacer(),
                                      SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: Container(
                                              color: getColorBasedOnCriticality(
                                                  double.parse(subject[
                                                      'criticalityvalue']))))
                                    ],
                                  ),
                                );
                              },
                            )
                          : Text('No Subjects Found',
                              style: GoogleFonts.poppins(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              )),
                    ),
                    SizedBox(height: 16),
                    ExpandablePanel(
                      header: Text(
                        'Skills Required',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      collapsed: Container(),
                      expanded: responseData?['occupationdetails']['skills']
                                  .length >
                              0
                          ? ListView.builder(
                              physics:
                                  NeverScrollableScrollPhysics(), // Make it not scrollable

                              itemCount: responseData?['occupationdetails']
                                      ['skills']
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var skills = responseData?['occupationdetails']
                                    ['skills'][index];

                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text(skills['skillsname'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      Spacer(),
                                      SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: Container(
                                              color: getColorBasedOnCriticality(
                                                  double.parse(skills[
                                                      'criticalityvalue']))))
                                    ],
                                  ),
                                );
                              },
                            )
                          : Text('No skills found',
                              style: GoogleFonts.poppins(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              )),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
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

class BarChartSample2 extends StatefulWidget {
  final String occupationName;
  final Map<String, dynamic> userPersonality;
  final Map<String, dynamic> careerPersonality;

  BarChartSample2(
      {super.key,
      required this.userPersonality,
      required this.careerPersonality,
      required this.occupationName});

  final Color leftBarColor = AppColors.contentColorYellow;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor =
      AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final userPersonality = widget.userPersonality;

    final occupationPersonality = widget.careerPersonality;

    final items = <BarChartGroupData>[];

    int position = 0;
    for (var entry in userPersonality.entries) {
      final barGroup = makeGroupData(
        position++,
        occupationPersonality[entry.key]!.toDouble(),
        entry.value.toDouble(),
      );
      items.add(barGroup);
    }

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 38,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 5,
                      child: Container(),
                    ),
                    Text(
                      clipText('${widget.occupationName} Personality', 15),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 38,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 5,
                      child: Container(),
                    ),
                    Text(
                      'My Personality',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 50) {
      text = '50%';
    } else if (value == 100) {
      text = '100%';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['ART', 'CONV', 'ENTR', 'INV', 'REA', 'SOC'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  String clipText(String originalText, int maxCharacters) {
    if (originalText.length <= maxCharacters) {
      return originalText;
    }

    return originalText.substring(0, maxCharacters) + '...';
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (this.red + other.red) ~/ 2;
    final green = (this.green + other.green) ~/ 2;
    final blue = (this.blue + other.blue) ~/ 2;
    final alpha = (this.alpha + other.alpha) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }
}
