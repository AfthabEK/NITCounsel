import '../welcomePage.dart';
import 'package:flutter/material.dart';
import '../comps/constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/options.dart';
import '../widgets/result.dart';
import 'user_dashboard.dart';
import 'create_chatreq.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

String? user = '';

int index = 0;
bool isPressed = false;
int score = 0;
Color select_color = Colors.white;
int select_index = -1;

class _HomePageState extends State<HomePage> {
  List<Question> _questions = [
    Question(
      questionid: '1',
      title: 'Where is CZ located?',
      options: {
        'Near basketball court': true,
        'Near CCC': false,
        'Above auditorium ': false,
        'Inside OAT': false,
      },
    ),
    Question(
      questionid: '2',
      title: 'Which of these buildings is not located inside the main campus?',
      options: {
        'ELHC': false,
        'ECLC': true,
        'NLHC': false,
        'MB': false,
      },
    ),
    Question(
      questionid: '3',
      title: 'Where is the green amphitheatre located?',
      options: {
        'Near MB': true,
        'Inside OAT': false,
        'Near basketball ground': false,
        'Inside SOMS': false,
      },
    ),
    Question(
      questionid: '4',
      title: 'Which of these hostels is located inside the main campus?',
      options: {
        'MHB 2': false,
        'FH': true,
        'LH': false,
        'IH': false,
      },
    ),
    Question(
      questionid: '5',
      title: 'How many hostels are there inside the main campus of NITC?',
      options: {
        '7': false,
        '8': false,
        '9': true,
        '10': false,
      },
    ),
    Question(
      questionid: '6',
      title: 'Who is the current director of NITC',
      options: {
        'Dr. S. M. Sameer': false,
        'Prof. Prasad Krishna': true,
        'Dr. S D Madhu Kumar': false,
        'Dr. Shamasundara M. S.': false,
      },
    ),
    Question(
      questionid: '7',
      title:
          'What is the name of the council of elected student representatives of NITC?',
      options: {
        'Students Welfare Council': false,
        'Students Administrative Council': false,
        'Students Elected Council': false,
        'Students Affairs Council': true,
      },
    ),
    Question(
      questionid: '8',
      title: 'What is the format of NITC student email?',
      options: {
        'rollno_firstname@nitc.ac.in': false,
        'firstname_rollno@nitc.ac.in': true,
        'rollno@nitc.ac.in': false,
        'name@nitc.ac.in': false,
      },
    ),
    Question(
      questionid: '9',
      title: 'What is the format of NITC faculty email?',
      options: {
        'id_name@nitc.ac.in': false,
        'name_id@nitc.ac.in': false,
        'id@nitc.ac.in': false,
        'name@nitc.ac.in': true,
      },
    ),
    Question(
      questionid: '10',
      title: 'How many canteens/food courts are there in NITC main campus?',
      options: {
        '4': false,
        '3': false,
        '2': true,
        '1': true,
      },
    ),
  ];

  void nextQuestion() {
    select_index = -1;
    if (score > 5) {
      signInAnonymously();
      int index = 0;
      bool isPressed = false;
      int score = 0;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePages(),
        ),
      );
    }
    if (index == _questions.length - 1) {
      if (score > 5) {
        int index = 0;
        bool isPressed = false;
        int score = 0;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePages(),
          ),
        );
      } else {
        setState(() {
          int index = 0;
          bool isPressed = false;
          int score = 0;
        });

        Navigator.pop(context);
      }
    }
    ;
    if (isPressed) {
      setState(() {
        if (index < _questions.length - 1) {
          index++;
          isPressed = false;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an option'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 20.0),
      ));
    }
  }

  void changeColor() {
    setState(() {
      isPressed = true;
    });
  }

  void checkAnswerAndUpdate(bool value) {
    if (isPressed) return;
    if (value == true) {
      score++;
    }
    setState(() {
      isPressed = true;
      if (index < _questions.length - 1) {}
    });
  }

  void StartAgain() {
    setState(() {
      index = 0;
      isPressed = false;
      score = 0;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        /*
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Score: $score'),
          )
        ],*/
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          QuestionWidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestions: _questions.length),
          const Divider(
            color: neutral,
          ),
          const SizedBox(height: 25),
          for (int i = 0; i < _questions[index].options.length; i++)
            InkWell(
              //highlightColor: Colors.blue,
              onTap: () {
                checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]);
                setState(() {
                  select_color = Colors.blue;
                  select_index = i;
                });
              },
              child: OptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: i == select_index ? select_color : Colors.white,
              ),
            )
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(nextQuestion: nextQuestion),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<void> signInAnonymously() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print(userCredential.user?.uid.toString());
    user = userCredential.user?.uid.toString();
    // Once the user is signed in, you can access the user information using userCredential.user
    // You can generate a random username for the user here and store it in your database
    // You can also navigate to the next screen or perform other actions as needed
  } catch (e) {
    // Handle any errors that may occur during sign in
    print('Failed to sign in anonymously: $e');
  }
}

// ...

Future<void> storeUsername(String userId, String username) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'username': username,
      // Add any other user information you want to store in the document
    });
    user = username;
    // Username and other user information is stored in Firestore with the document ID as the user ID
  } catch (e) {
    // Handle any errors that may occur while storing the username
    print('Failed to store username: $e');
  }
}
