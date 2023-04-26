import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nitcsupport/welcomePage.dart';

class FeedbackPage extends StatefulWidget {
  final String mentorUid; // Mentor's UID passed from previous page

  FeedbackPage({Key? key, required this.mentorUid}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int?
      _feelingBetter; // Selected option for "Do you feel better after this session?"
  int?
      _foundSolution; // Selected option for "Were you able to find a solution to your problem?"
  int _mentorRating = 3; // Initial rating for mentor on a scale of 1 to 5
  String _comments = ""; // Additional comments

  void _submitFeedback() async {
    // Create a map to store the feedback data
    Map<String, dynamic> feedbackData = {
      "feelingBetter": _feelingBetter == 1 ? true : false,
      "foundSolution": _foundSolution == 1 ? true : false,
      "mentorRating": _mentorRating,
      "comments": _comments,
      "mentorUid": widget.mentorUid,
      "timestamp": FieldValue.serverTimestamp(),
    };

    // Store the feedback data in Firestore
    await FirebaseFirestore.instance.collection("feedback").add(feedbackData);

    await Future.delayed(Duration(seconds: 1));

    // Show a snackbar indicating successful submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Feedback submitted successfully!"),
      ),
    );

    //logout the user
    await FirebaseAuth.instance.signOut();

    // Navigate back to the first page till the first page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Do you feel better after this session?",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _feelingBetter,
                  onChanged: (value) {
                    setState(() {
                      _feelingBetter = value;
                    });
                  },
                ),
                Text("Yes"),
                Radio<int>(
                  value: 0,
                  groupValue: _feelingBetter,
                  onChanged: (value) {
                    setState(() {
                      _feelingBetter = value;
                    });
                  },
                ),
                Text("No"),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              "Were you able to find a solution to your problem?",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _foundSolution,
                  onChanged: (value) {
                    setState(() {
                      _foundSolution = value;
                    });
                  },
                ),
                Text("Yes"),
                Radio<int>(
                  value: 0,
                  groupValue: _foundSolution,
                  onChanged: (value) {
                    setState(() {
                      _foundSolution = value;
                    });
                  },
                ),
                Text("No"),
              ],
            ),
            Column(
              children: [
                Text(
                  "How would you rate this mentor on a scale of 1 to 5?",
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= 5; i++)
                      Column(
                        children: [
                          Text(
                            i.toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Radio<int>(
                            value: i,
                            groupValue: _mentorRating,
                            onChanged: (value) {
                              setState(() {
                                _mentorRating = value!;
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text("Do you have anything to suggest to the mentor?"),
            TextField(
              onChanged: (value) {
                setState(() {
                  _comments = value;
                });
              },
              maxLines: 4,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitFeedback();
                //pop everything and go to home page
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("Submit"),
            ),
            ElevatedButton(
              onPressed: () {
                //_submitFeedback();
                //pop everything and go to home page
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("Skip Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}
