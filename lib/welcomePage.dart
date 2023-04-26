import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'comps/constants.dart';
import 'models/question_model.dart';
import 'widgets/question_widget.dart';
import 'widgets/next_button.dart';
import 'widgets/options.dart';
import 'widgets/result.dart';
import 'userScreens/question_page.dart';
import 'mentorScreens/login_mentor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF32526C),

      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color(0xFF32526C),
                  Colors.lightBlue.shade200,

                ],
              )
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to NITCSupport",
                      style: GoogleFonts.plusJakartaSans(fontSize: 24, color: Colors.black),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF32526C)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: Text("Login",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18, color: Colors.lightBlueAccent)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MentorLoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Login as mentor",
                          style: TextStyle(fontSize:15,color: Colors.black),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginSGC(),
                              ),
                            );
                          },
                          child: Text(
                            "SGC Login",
                            style: TextStyle(fontSize:15,color: Colors.black),
                          ))
                    ]),
              ),
            ],
          ),
        ),),
    );
  }
}
