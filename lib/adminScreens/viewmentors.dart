import 'adminDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'viewfeedbacksgc.dart';

class ViewMentors extends StatefulWidget {
  @override
  _ViewMentorsState createState() => _ViewMentorsState();
}

class _ViewMentorsState extends State<ViewMentors> {
  Future<void> removeMentor(String uid) async {
    setState(() {
      FirebaseFirestore.instance.collection('mentors').doc(uid).delete();
    });
  }

  Future<List<Mentor>> fetchMentors() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('mentors').get();

    List<Mentor> mentors = [];
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        // Create a Mentor object from the fetched data
        Mentor mentor = Mentor(
          email: data['email'] ?? '',
          uid: data['user_id'] ?? '',
        );
        mentors.add(mentor);
      }
    }
    return mentors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentors'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Mentor>>(
        future: fetchMentors(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Mentor>? mentors = snapshot.data;
            if (mentors != null) {
              return ListView.builder(
                itemCount: mentors.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(mentors[index].email),
                      subtitle: Text(mentors[index].uid),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle remove mentor button click
                              removeMentor(mentors[index].uid);
                            },
                            child: Text('Remove Mentor'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // Handle view feedback button click
                              ViewFeedback(muid: mentors[index].uid);
                            },
                            child: Text('View Feedback'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Mentor {
  final String email;

  final String uid;

  Mentor({
    required this.email,
    required this.uid,
  });
}
