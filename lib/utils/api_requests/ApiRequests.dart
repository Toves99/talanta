import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
import 'package:talanta_new/utils/models/QuizCategory.dart';

class ApiRequests {
  Future<Map<String, dynamic>?> authenticateAndSaveToken(
      String email, String password) async {
    final Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
      "method": "custom_email",
    };

    try {
      final response = await http.post(
        Uri.parse(APIEndpoints.loginEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print("RESP ${APIEndpoints.loginEndpoint} ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String? token = data["data"]["token"];
        if (token != null) {
          // Save the token for later use, e.g., in secure storage or shared preferences.
          // Here, we are just returning it for demonstration purposes.
          var userID = data["data"]["_pid"];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userID', userID);

          return {
            "token": token,
          };
        } else {
          return {"message": "Authentication failed: Missing token"};
        }
      } else if (response.statusCode == 500) {
        return {"message": "Server error 500"};
      } else if (response.statusCode == 400) {
        return {"message": "Bad request 400: ${response.body}"};
      } else {
        return {
          "message": "${response.statusCode} Server error - ${response.reasonPhrase}"
        };
      }
    } catch (exception) {
      // Handle network or other exceptions.

      if (exception is SocketException) {
        return {"message": "Please Check Your Network Connection"};
      }

      if (exception is FormatException) {
        return {"message": "Invalid format: ${exception.message}"};
      }

      if (exception is HttpException) {
        return {"message": "HTTP error: ${exception.message}"};
      }

      if (exception is TimeoutException) {
        return {"message": "Request Timed Out. Please try again later."};
      }
    }
  }

  //
  Future<Map<String, dynamic>> fetchPersonalityTestResult(int position) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = await prefs.getInt('userID');
    var requestBody = {
      "pid": userID,
      "limit": 0,
    };
    final response = await http.post(
      Uri.parse(APIEndpoints.retrievePersonality),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      print("PERSONALITY DASH 1$data");

      if (data['status'] == true && data['data']['userpersonality'] != null) {
        // Sort the personality tests by date (assuming the date is in ISO 8601 format)
        final personalityTests = List.from(data['data']['userpersonality']);
        personalityTests.sort((a, b) {
          return DateTime.parse(b['created_at'])
              .compareTo(DateTime.parse(a['created_at']));
        });

        print("PERSONALITY DASH 2$data");


        return personalityTests[position]; // Get the most recent test
      } else {
        print("PERSONALITY DASH 3$data");

        throw Exception('Failed to fetch personality test data');
      }
    } else {
      print("PERSONALITY DASH 4");

      throw Exception('Failed to load personality test data');
    }
  }

  ///Fetch Personalirt Test
  Future<Map<String, QuizCategory>> fetchQuizData() async {
    final response = await http.get(
      Uri.parse(APIEndpoints.personalityQuestionsEndpoint),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];

      print("DATA : ${data}");
      Map<String, QuizCategory> quizCategories = {};

      data.forEach((category, questions) {
        Map<int, String> questionMap = {};
        questions.forEach((key, value) {
          questionMap[int.parse(key)] = value as String;
        });
        quizCategories[category] = QuizCategory(
          questions: questionMap,
        );
      });

      print('Quiz Categories : $quizCategories');
      return quizCategories;
    } else {
      print("DATA ERROR : ${response.body}");

      throw Exception('Failed to load quiz data');
    }
  }

  ///Sign UP
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
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "dob": dob,
      "gender": gender,
      "rememberMe": rememberMe,
    };

    try {
      final response = await http.post(
        Uri.parse(APIEndpoints.signupEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // User registration successful, you may handle success logic here.
        return true;
      } else {
        // Handle API errors (e.g., registration failed).
        return false;
      }
    } catch (exception) {
      // Handle network or other exceptions.
      return false;
    }
  }

  Future<bool> isPaid(int id) async {
    // Define your API endpoint
    String apiUrl = "${APIEndpoints.josdapURL}/talanta2/talanta.api.josdap";

    // Make the API request
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "object": "userpayments",
        "command": "select",
        "id": 0,
        "fields": "*",
        "conditions": "personalityid=$id AND paymentstatus='PAID' ORDER BY ID DESC",
        "limit": 0,
        "returnchildobjects": 0,
        "childobjectsfilter": [],
        "sortfield": "",
        "sortcriteria": "",
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response
      Map<String, dynamic> data = jsonDecode(response.body);

      print("LION" + response.body);

      // Check if the userpayments array is not empty
      bool isPaid = data['output']['data']['userpayments'].isNotEmpty;

      return isPaid;
    } else {
      print("KIOY" + response.body);

      print(response.body);
      return false;
    }
  }
}
