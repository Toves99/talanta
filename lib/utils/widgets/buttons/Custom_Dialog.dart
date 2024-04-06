import 'package:flutter/material.dart';

class CustomProgressDialog {
  late OverlayEntry _overlayEntry;

  void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _buildProgressDialog(context),
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  void hide() {
    _overlayEntry.remove();
  }

  Widget _buildProgressDialog(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: MediaQuery.of(context).size.width * 0.4,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   final CustomProgressDialog progressDialog = CustomProgressDialog();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Progress Dialog'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             progressDialog.show(context);
//             // Simulate some time-consuming task
//             Future.delayed(Duration(seconds: 3), () {
//               progressDialog.hide();
//             });
//           },
//           child: Text('Show Progress Dialog'),
//         ),
//       ),
//     );
//   }
// }
