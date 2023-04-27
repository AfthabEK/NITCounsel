import 'package:flutter/material.dart';
import 'mentor_dashboard.dart';

class ViewFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyTextPage());
  }
}

class MyTextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "View Feedback",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MentorDashboard(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Text(
            "Average rating : 3.5",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 8),
          Text(
            "Problem Solved?\n -Yes : 9\n -No : 3",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 8),
          Text(
            "Felt better?\n -Yes : 8\n -No : 4",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 8),
          Text(
            "User reviews:",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.cyan.shade600,
            ),
            child: Text(
                """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. """,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.cyan.shade600,
            ),
            child: Text(
                """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. """,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
