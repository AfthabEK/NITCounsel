import 'package:flutter/material.dart';
import 'package:nitcsupport/userScreens/create_chatreq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'view_req_user.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom NavBar Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF32526C),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const Page4(),
    MyForm(),
    ViewReqUser(),

  ];
  bool _canShowButton = true;
  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcac4df),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              checkChatRequestExists(
                  FirebaseAuth.instance.currentUser!.uid.toString())
                  .then((value) {
                if (value) {
                  //if chat request exists, then view the chat request
                  hideWidget();
                } else {
                  //if chat request does not exist, then create a new chat request
                  setState(() {
                    pageIndex = 1;
                  });
                }
              });

            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.add_comment_outlined,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.add_comment,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.chat,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.chat_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 1",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffcac4df),
      child: Center(
        child: Text(
          "Page Number 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffcac4df),
      child: Center(
        child: Text(
          "Page Number 3",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self help content'),
        backgroundColor: const Color(0xFF32526C),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset('lib/images/self1.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            Image.asset('lib/images/self2.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
          ],

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