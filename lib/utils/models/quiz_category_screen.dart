// import 'package:flutter/material.dart';
// import 'package:talanta_new/screens/personality_test/quiz_page.dart';
// import 'package:talanta_new/utils/api_requests/APIEndpoints.dart';
// import 'package:talanta_new/utils/api_requests/ApiRequests.dart';
// import 'package:talanta_new/utils/models/QuizCategory.dart';
//
// class QuizCategoriesScreen extends StatelessWidget {
//   ApiRequests _apiRequests = new ApiRequests();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Quiz Categories"),
//       ),
//       body: FutureBuilder(
//         future: _apiRequests.fetchQuizData(),
//         builder: (BuildContext context,
//             AsyncSnapshot<Map<String, QuizCategory>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final Map<String, QuizCategory> quizData = snapshot.data!;
//             return ListView.builder(
//               itemCount: quizData.length,
//               itemBuilder: (context, index) {
//                 String category = quizData.keys.elementAt(index);
//                 QuizCategory categoryData = quizData[category]!;
//                 return ListTile(
//                   title: Text(category),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => QuizCategoryPage(
//                           category: category,
//                           questions: categoryData.questions,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No data available.'));
//           }
//         },
//       ),
//     );
//   }
// }
