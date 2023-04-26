import 'package:flutter/material.dart';
import 'package:nitcsupport/userScreens/create_chatreq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'view_req_user.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {
                  //if there is no chat request, then create a new chat request
                  //else, view the chat request
                  checkChatRequestExists(
                          FirebaseAuth.instance.currentUser!.uid.toString())
                      .then((value) {
                    if (value) {
                      //if chat request exists, then view the chat request
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserDashboard(),
                        ),
                      );
                    } else {
                      //if chat request does not exist, then create a new chat request
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyForm(),
                        ),
                      );
                    }
                  });
                },
                label: Text("Create Chat Request",
                    style: TextStyle(color: Colors.black)),
                icon: Icon(Icons.add),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewReqUser(),
                          ),
                        );
                      },
                      child: Text("View chat request",
                          style: TextStyle(color: Colors.black))),
                  TextButton(
                      onPressed: () {},
                      child: Text("View self-help content",
                          style: TextStyle(color: Colors.black)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> checkChatRequestExists(String user_id) async {
  try {
    // Create a reference to the 'chatRequests' collection in Firestore
    CollectionReference chatRequestsRef =
        FirebaseFirestore.instance.collection('chatRequests');

    // Query the collection to check if a document with the given user ID exists
    QuerySnapshot querySnapshot =
        await chatRequestsRef.where('user_id', isEqualTo: user_id).get();

    // If the query snapshot contains any documents, it means the chat request exists
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors that may occur while checking for chat request existence
    print('Failed to check chat request existence: $e');
    return false;
  }
}
