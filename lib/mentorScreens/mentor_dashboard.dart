import 'package:firebase_auth/firebase_auth.dart';
import 'package:nitcsupport/mentorScreens/chatpage.dart';

import '../userScreens/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'view_feedback.dart';
import 'login_mentor.dart';
import 'viewfeedback.dart';
import 'mentorchatreq.dart';

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({super.key});

  @override
  State<MentorDashboard> createState() => MentorDashboardState();
}

class MentorDashboardState extends State<MentorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xFF32526C),
              Colors.lightBlue.shade200,
            ],
          )),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      """






Welcome Mentor""",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF32526C),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatRequestListScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(" View Chat Requests/ Chat ",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                color: Colors.lightBlue.shade200)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF32526C),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewFeedback(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 10.0),
                        child: Text("View feedback",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                color: Colors.lightBlue.shade200)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF32526C),
                        ),
                      ),
                      onPressed: () {
                        mentorLogout(context);

                        Navigator.of(context).pop();
                        /*
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );*/
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100.0, vertical: 10.0),
                        child: Text("Log out",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                color: Colors.lightBlue.shade200)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void mentorLogout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Redirect to login screen after successful logout
  } catch (e) {
    print('Error logging out: $e');
    // Show an error dialog if logout fails
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to logout. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {},
              ),
            ],
          );
        });
  }
}
