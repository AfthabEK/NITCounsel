import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nitcsupport/userScreens/create_chatreq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'view_req_user.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
              Icons.add_comment,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.add_comment_outlined,
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
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: Text("Self-Help Content"),
        backgroundColor: const Color(0xFF32526C),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.help),
              onPressed: () => {showAlertDialog(context)}),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Center(
        child:
        ListView(
          children: [
            CarouselSlider(
              items: [

                //1st Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xFF32526C),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://th.bing.com/th/id/OIP.S7bBWFirlQiKyDGiYzOnLwHaFh?pid=ImgDet&rs=1"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://quotefancy.com/media/wallpaper/3840x2160/9844-Friedrich-Nietzsche-Quote-You-have-your-way-I-have-my-way-As-for.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //3rd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://quotefancy.com/media/wallpaper/3840x2160/6297157-Mike-Moreno-Quote-Just-remember-you-are-not-alone-in-fact-you-are.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                //4th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: NetworkImage("ADD IMAGE URL HERE"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                //5th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: NetworkImage("ADD IMAGE URL HERE"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

              ],

              //Slider Container properties
              options: CarouselOptions(
                height: 240.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 30 / 15,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 500),
                viewportFraction: 0.8,
              ),
            ),

            Text(
              textAlign: TextAlign.center,
              "\nWelcome to NITCSupport\n",
              style: GoogleFonts.plusJakartaSans(fontSize: 24, color: Colors.black),
            ),
            Container(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF32526C),
                            Colors.lightBlue.shade200,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]
                    ),
                    child:ElevatedButton(
                      child: Text("Videos"),
                      onPressed: null,
                      style: ElevatedButton.styleFrom(fixedSize: const Size(150, 200),shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                    ),),
                  SizedBox(width: 40),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF32526C),
                            Colors.lightBlue.shade200,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]
                    ),
                    child:ElevatedButton(
                      child: Text("Stories"),
                      onPressed: null,
                      style: ElevatedButton.styleFrom(fixedSize: const Size(150, 200),shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                    ),),
                ],
              ),
            ),

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

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(onPressed: (){Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );}, child: Text("OK"),);

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Instructions"),
    content: Text("1. Create a chat request with description about your issue and selecting suitable tags.\n"
        "2. View chat Request to check your status.\n"
        "3. Once your status changes to accepted from pending, you may chat with your mentor."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}