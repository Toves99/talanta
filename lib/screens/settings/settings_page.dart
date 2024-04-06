import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_sharp)),
              Spacer(),
              Text('Settings',
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
          // Show Notifications
          // Update User Details
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Update Details',
                style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
            onTap: () {
              // Navigate to the user details update page.
              // You can implement this navigation as needed.
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Show Notifications',
                style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
            trailing: Switch(
              value:
                  true, // You can bind this to a state variable to manage notifications.
              onChanged: (value) {
                // Handle the toggle action here.
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.payments_sharp),
            title: Text('Payments History',
                style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
            onTap: () {
              // Navigate to the user details update page.
              // You can implement this navigation as needed.
            },
          ),
          // Logout
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text('Logout',
                style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400)),
            onTap: () {
              // Implement the logout action here.
              // You can show a confirmation dialog before logging out.
            },
          ),
        ],
      ),
    );
  }
}
