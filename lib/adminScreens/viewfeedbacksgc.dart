import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({Key? key, required this.muid}) : super(key: key);
  final String muid;
  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Feedback'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .where('mentorUid',
                isEqualTo: widget.muid) // Filter by mentor's UID
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
