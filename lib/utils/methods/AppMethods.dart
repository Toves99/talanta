import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_bar_chart/sliver_bar_chart.dart';
import 'dart:math' as math;


class AppMethods{

  void _setupBarChartValues() {
    var _barValues = [
      BarChartData(
        x: '2014',
        y: 500.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2015',
        y: 800.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2016',
        y: 600.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2017',
        y: 900.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2018',
        y: 1000.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2019',
        y: 700.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2020',
        y: 500.0,
        barColor: getRandomColor(),
      ),
      BarChartData(
        x: '2021',
        y: 300.0,
        barColor: getRandomColor(),
      ),
    ];

  }

  Color getRandomColor() {
    return Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withOpacity(1.0);
  }



  Future<Map<String, dynamic>> getResponseDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responsesString = prefs.getString("responses");


    if (responsesString != null) {
      // Parse the string back into a map
      Map<String, Map<String, dynamic>> categoryResponses =
      Map<String, Map<String, dynamic>>.from(jsonDecode(responsesString));
      // Calculate percentages
      Map<String, double> percentages = {};
      categoryResponses.forEach((category, data) {
        int totalResponses = (data["Yes"] ?? 0) + (data["No"] ?? 0);
        if (totalResponses > 0) {
          double percentage = (data["Yes"] ?? 0) / totalResponses * 100;
          percentages[category] = percentage;
        } else {
          percentages[category] = 0.0; // Handle division by zero
        }
      });
      return percentages;
    }
    return {};
  }

}