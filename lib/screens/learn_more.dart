import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  Text('Learn More About Tests',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          color: const Color(0xfff566370),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  Spacer(),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 16),
              Text(
                'Conventional Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'They love routine work. They like following procedures and well-defined rules or would love work that is routine, involves following established procedures, methods, tools, and practices',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              Text(
                'Investigative Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                'They are analytical, curious, logical, critical, and abstract thinkers. Enjoy solving complex problems. They are inventors and innovators',  style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              Text(
                'Realistic Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'They love working on practical issues and problems. They love tinkering with machinery and physical things', style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              Text(
                'Enterprising Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'They love business, managerial, leadership, and commercial work. They love sales, marketing & product development', style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              Text(
                'Social Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'They care a lot about others\' well-being. They would love to be engaged in activities related to relieving others\' pain, counseling others, fighting hunger, etc.', style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              Text(
                'Artistic Personality Type',
                style: GoogleFonts.poppins(
                    color: const Color(0xfff566370),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'They care a lot about others\' well-being. They would love to be engaged in activities related to relieving others\' pain, counseling others, fighting hunger, etc.', style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
