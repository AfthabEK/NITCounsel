import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_dashboard.dart';
import '../mentorScreens/ChatInitPage.dart';
import 'ChatPage.dart';

class ChatRequest {
  final String title;
  final String description;
  final List<String> tags;
  final String status;
  final Timestamp timeCreated;
  final String acceptedBy;

  ChatRequest({
    required this.title,
    required this.description,
    required this.tags,
    required this.status,
    required this.timeCreated,
    required this.acceptedBy,
  });
}

String muid = '';

class ViewReqUser extends StatefulWidget {
  @override
  _ViewReqUserState createState() => _ViewReqUserState();
}

class _ViewReqUserState extends State<ViewReqUser> {
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<List<ChatRequest>> fetchChatRequestsByUid() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chatRequests')
        .where('user_id', isEqualTo: uid)
        .get();

    List<ChatRequest> chatRequests = [];
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        // Create a ChatRequest object from the fetched data
        ChatRequest chatRequest = ChatRequest(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          tags: List<String>.from(data['tags'] ?? []),
          status: data['status'] ?? '',
          timeCreated: data['timeCreated'] ?? Timestamp.now(),
          acceptedBy: data['acceptedBy'] ?? '',
        );
        chatRequests.add(chatRequest);
      }
    }
    return chatRequests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF32526C),
        title: Text(
          "View Chat Requests",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: FutureBuilder<List<ChatRequest>>(
          future: fetchChatRequestsByUid(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Handle loading state
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                // Handle error state
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data != null && snapshot.data!.length > 0) {
                  // Display chat requests
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      ChatRequest chat = snapshot.data![index];
                      return ListTile(
                        title: Text(chat.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ${chat.description}'),
                            Text('Tags: ${chat.tags.join(", ")}'),
                            Text('Status: ${chat.status}'),
                            Text(
                                'Created on: ${chat.timeCreated.toDate().toString()}'),
                          ],
                        ),
                        onTap: () {
                          //Navigate to home
                          fetchAcceptedBy(FirebaseAuth.instance.currentUser!.uid
                              .toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserChatPage(id: muid),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
// Handle empty state
                  return Text('No chat requests found.');
                }
              }
            }
          },
        ),
      ),
    );
  }
}

//function to fetch acceptedby from chatrequest collection given uid of user
Future<String> fetchAcceptedBy(String uid) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('chatRequests')
      .where('user_id', isEqualTo: uid)
      .get();

  String acceptedBy = '';
  for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      // Create a ChatRequest object from the fetched data
      acceptedBy = data['acceptedBy'] ?? '';
    }
  }
  muid = await acceptedBy;
  print(muid);
  return acceptedBy;
}
