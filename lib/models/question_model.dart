class Question {
  final String questionid;
  final String title;

  final Map<String, bool> options;

  Question({
    required this.questionid,
    required this.title,
    required this.options,
  });

  @override
  String toString() {
    return 'Question{questionid: $questionid, title: $title, options: $options}';
  }
}
