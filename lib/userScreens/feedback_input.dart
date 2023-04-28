import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nitcsupport/welcomePage.dart';

class Feedbacknew extends StatefulWidget {
  final String mentorUid;

  Feedbacknew({Key? key, required this.mentorUid}) : super(key: key);

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedbacknew> {
  int? _feelingBetter;
  int? _foundSolution;
  int _mentorRating = 3;
  String _comments = "";
  final double spacing = 8;

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

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Feedback",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text(
                "Do you feel better after this session?",
                style: TextStyle(color: Colors.deepPurple, fontSize: 24),
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
              const SizedBox(height: 10.0),
              Text(
                "Were you able to find a solution to your problem?",
                style: TextStyle(color: Colors.deepPurple, fontSize: 24),
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
              const SizedBox(height: 10.0),
              Text(
                "How would you rate this mentor on a scale of 1 to 5?",
                style: TextStyle(color: Colors.deepPurple, fontSize: 24),
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
              const SizedBox(height: 10.0),
              Text(
                "Do you have anything to suggest to the mentor?",
                style: TextStyle(color: Colors.deepPurple, fontSize: 24),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _comments = value;
                        });
                      },
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    submitBtn(context),
                    const SizedBox(height: 10.0),
                    skipBtn(context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  OutlinedButton submitBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        _submitFeedback();
        //Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
        //String description = _productDesController.text;
        //String user_id = FirebaseAuth.instance.currentUser!.uid;
      },
      child: Text(
        "Submit".toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  OutlinedButton skipBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
        //Navigator.of(context).popUntil((route) => route.isFirst);
        //String description = _productDesController.text;
        //String user_id = FirebaseAuth.instance.currentUser!.uid;
      },
      child: Text(
        "Skip Feedback".toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
    );
  }
}
