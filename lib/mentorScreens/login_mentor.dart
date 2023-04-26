import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../adminScreens/adminDashboard.dart';
import 'mentor_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Logics/auth.dart';

//create an auth object
auth authenticate = auth();
String? userid;
String Email = "";
String Password = "";

class LoginSGC extends StatelessWidget {
  const LoginSGC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF32526C), Color(0xFF719AD0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "    SGC Login",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF32526C), Color(0xFF719AD0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (email) {
                          Email = email;
                        },
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.drive_file_rename_outline,
                              color: Color(0xFF2B5581),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Username",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (password) {
                          Password = password;
                        },
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFF2B5581),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {
                                //userid = await authenticate.register_user(
                                //  Email, Password);
                                //if (userid != null) {
                                //print(userid);
                                //}
                                // if userid is sgc and password is 12345678 login, else say wrong password or username
                                if (Email == "sgc" && Password == "12345678") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AdminDashboard(),
                                    ),
                                  );
                                } else {
                                  //show snackbar wrong username or password
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Wrong username or password'),
                                  ));
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF677CC9),
                                    Color(0xFF2B5581)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MentorLoginPage extends StatefulWidget {
  @override
  _MentorLoginPageState createState() => _MentorLoginPageState();
}

class _MentorLoginPageState extends State<MentorLoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _loginError = '';

  // Function to handle mentor login
  Future<void> _loginMentor(String email, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Mentor logged in: ${userCredential.user!.uid}');
      //Navigate to mentor dashboard
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MentorDashboard(),
        ),
      );
      // Navigate to the mentor home page or perform any desired action upon successful login
    } catch (e) {
      setState(() {
        _loginError = 'Failed to log in: $e';
      });
    }
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF32526C), Color(0xFF719AD0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "         Mentor Login",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF32526C), Color(0xFF719AD0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        onChanged: (email) {
                          Email = email;
                        },
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.drive_file_rename_outline,
                              color: Color(0xFF2B5581),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        onChanged: (password) {
                          Password = password;
                        },
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFF2B5581),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                _loginMentor(email, password);
                              },
                              child: const Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF677CC9),
                                    Color(0xFF2B5581)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        _loginError,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
// Usage example:
// Use MentorLoginPage in your app to show the mentor login page
