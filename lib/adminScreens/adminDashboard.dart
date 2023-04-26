import 'package:nitcsupport/welcomePage.dart';

import '../userScreens/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../mentorScreens/view_feedback.dart';
import 'addMentor.dart';
import 'view_questions.dart';
import 'viewmentors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 39, 163, 221),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              //height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    """



Welcome SGC Admin""",
                    style: TextStyle(fontSize: 27),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => add_mentors(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 10.0),
                      child: Text("    Add mentors    ",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  /**/
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {
                      //navigate ti view mentors
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewMentors(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 10.0),
                      child: Text("   View mentors   ",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EditQuestion(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 10.0),
                      child: Text(" Edit Questions ",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      child: Text("Edit Self-help Content",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 10.0),
                      child: Text(" Logout  ",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
