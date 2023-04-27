import 'package:nitcsupport/mentorScreens/mentor_dashboard.dart';
import 'package:nitcsupport/userScreens/create_chatreq.dart';

import 'welcomePage.dart';
import 'package:flutter/material.dart';
import 'userScreens/give_feedback.dart';
import 'userScreens/feedback_input.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //initialize firebase

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '3.2 Flutter Push Pop',
        theme: ThemeData.light(),
        home: LoginPage());
        //home: MyForm()
        //home: FeedbackPage(mentorUid: "123"));
        //home: Feedbacknew(mentorUid: "123"));
  }
}
