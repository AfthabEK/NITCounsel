import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewFeedback extends StatefulWidget {
  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  late String mentorUid;

  @override
  void initState() {
    super.initState();
    // Fetch the logged-in mentor's UID
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      mentorUid = currentUser.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Feedback'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .where('mentorUid', isEqualTo: mentorUid) // Filter by mentor's UID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final feedbackDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: feedbackDocs.length,
              itemBuilder: (context, index) {
                final feedbackData =
                    feedbackDocs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('${feedbackData['comments']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Feeling Better: ${feedbackData['feelingBetter']}'),
                      Text('Found Solution: ${feedbackData['foundSolution']}'),
                      Text('Mentor Rating: ${feedbackData['mentorRating']}'),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
