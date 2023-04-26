import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../comps/styles.dart';
import '../comps/widgets.dart';
import 'package:intl/intl.dart';
import 'give_feedback.dart';

class UserChatPage extends StatefulWidget {
  const UserChatPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<UserChatPage> createState() => _ChatInitPageState();
}

class _ChatInitPageState extends State<UserChatPage> {
  var roomId;

  Future<void> _closeChat() async {
    final firestore = FirebaseFirestore.instance;

    // Get the reference to the current chat room
    DocumentReference<Map<String, dynamic>> roomRef =
        firestore.collection('Rooms').doc(roomId);

    Map<String, dynamic> data = {
      'message': 'THE CHAT HAS BEEN CLOSED BY THE STUDENT',
      'sent_by': FirebaseAuth.instance.currentUser!.uid,
      'datetime': DateTime.now(),
    };
    firestore.collection('Rooms').doc(roomId).update({
      'last_message_time': DateTime.now(),
      'last_message': 'THE CHAT HAS BEEN CLOSED BY THE STUDENT',
    });
    firestore.collection('Rooms').doc(roomId).collection('messages').add(data);

    // set availability of mentor to true
    firestore
        .collection('mentors')
        .doc(widget.id)
        .update({'availability': true});

    // navigate to chat requests page
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => (FeedbackPage(mentorUid: widget.id)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: Text(''),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected option
              if (value == 'closeChat') {
                setState(() {
                  _closeChat();
                });
                
              } else if (value == 'sendWarning') {}
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'closeChat',
                child: Text('Close Chat'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: StreamBuilder(
                  stream: firestore.collection('Rooms').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot?> allData = snapshot
                            .data!.docs
                            .where((element) => element['users'].contains(
                                FirebaseAuth.instance.currentUser!.uid))
                            .toList();
                        QueryDocumentSnapshot? data =
                            allData.isNotEmpty ? allData.first : null;
                        if (data != null) {
                          roomId = data.id;
                        }
                        return data == null
                            ? Container()
                            : StreamBuilder(
                                stream: data.reference
                                    .collection('messages')
                                    .orderBy('datetime', descending: true)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? Container()
                                      : ListView.builder(
                                          itemCount: snap.data!.docs.length,
                                          reverse: true,
                                          itemBuilder: (context, i) {
                                            if (snap.data!.docs[i]['message'] ==
                                                'The chat has been closed by the mentor') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'The chat has been closed by the mentor')));

                                              //navogate to feedbackpage
                                              setState(() {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        (FeedbackPage(
                                                            mentorUid:
                                                                widget.id)),
                                                  ),
                                                );
                                              });

                                              //navigate to dasboard
                                              //show snackbar 'chat has been closed by the mentor'
                                            }
                                            return ChatWidgets.messagesCard(
                                                snap.data!.docs[i]['sent_by'] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                snap.data!.docs[i]['message'],
                                                DateFormat('hh:mm a').format(
                                                    snap.data!
                                                        .docs[i]['datetime']
                                                        .toDate()));
                                          },
                                        );
                                });
                      } else {
                        return Center(
                          child: Text(
                            'No conversation found',
                            style: Styles.h1()
                                .copyWith(color: Colors.indigo.shade400),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    }
                  }),
            ),
          ),
          Container(
            color: Colors.white,
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (controller.text.toString() != '') {
                if (roomId != null) {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').doc(roomId).update({
                    'last_message_time': DateTime.now(),
                    'last_message': controller.text,
                  });
                  firestore
                      .collection('Rooms')
                      .doc(roomId)
                      .collection('messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').add({
                    'users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid,
                    ],
                    'last_message': controller.text,
                    'last_message_time': DateTime.now(),
                  }).then((value) async {
                    value.collection('messages').add(data);
                  });
                }
              }
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
