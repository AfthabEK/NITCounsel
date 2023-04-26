import 'package:firebase_auth/firebase_auth.dart';
import '../userScreens/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_mentor.dart';
import 'viewfeedback.dart';
import 'mentorchatreq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({super.key});

  @override
  State<MentorDashboard> createState() => MentorDashboardState();
}

class MentorDashboardState extends State<MentorDashboard> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          Color.fromARGB(255, 211, 194, 194)),
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
                      mentorLogout(context);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 10.0),
                      child: Text("Log out",
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
