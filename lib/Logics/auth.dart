import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class auth {
  //Instance is similar to malloc in C.Each time it is called a new copy of the object is created rather than using the same object for each call which in turn overwrites the data.

  final FirebaseAuth _user = FirebaseAuth
      .instance; //_auth contains all the details of the user who is trying to sign in,sign  out or register;

///////////////////////////////////////////////
  // Sign in with email and password

  Future signinwithemailandpassword(String email, String password) async {
    try {
      final signin_response = await _user.signInWithEmailAndPassword(
          email: email, password: password);
      final user = signin_response.user;

      return user != null ? user.uid : null;
    } catch (e) {
      print("Sign in Error:${e}");
      return null;
    }
  }

  /////////////////////////////////////////////
  //Register with email and password:
  //Note:While registering ,if the registration becomes successfull,then automatically the user is signed in and auth status is changed;
  Future register_user(String email, String password) async {
    try {
      final response = await _user.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = response.user;

      return user != null
          ? user.uid
          : null; //this happens if the email or password is not in the prescribed format
    } catch (e) {
      print(
          "Error registering user:${e}"); //this occurs when there is a connection error in sending and receiving requests
      return null;
    }
  }

  ////////////////////////////////////////////////////////////
  //Sign out

  Future signout() async {
    try {
      await _user.signOut();
      return true;
    } catch (e) {
      print("Error Occurred:e");
      return false;
    }
  }

///////////////////////////////////////////////////////////////
  Stream<String?> get user_status {
    return _user.authStateChanges().map(
        (User? user_status) => user_status != null ? user_status.uid : null);
  }

  ///////////////////////////////////////////////////////////////
}
