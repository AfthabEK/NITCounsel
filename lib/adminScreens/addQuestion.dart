import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const add());

class add extends StatelessWidget {
  const add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const QuestionForm(),
    );
  }
}

const options = ['A', 'B', 'C', 'D'];

class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key}) : super(key: key);

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _questionCtrl = TextEditingController();
  final _optionCtrls = options.map((o) => TextEditingController()).toList();
  final _question = {'value': '', 'correct': options[0], 'options': options};

  void showSnackbar({required bool success, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 96,
          right: 16,
          left: 16,
        ),
        behavior: SnackBarBehavior.floating,
        content: Row(children: [
          Icon(
            success ? Icons.gpp_good : Icons.error,
            color: success ? Colors.greenAccent : Colors.redAccent,
          ),
          const SizedBox(width: 8),
          Text(text),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    for (var ctrl in _optionCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
          backgroundColor: Color.fromARGB(255, 76, 116, 175),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(padding: const EdgeInsets.all(32), children: [
            TextFormField(
              controller: _questionCtrl,
              decoration: const InputDecoration(labelText: 'Question *'),
              validator: (v) =>
                  v!.isEmpty ? 'Please fill in the Question' : null,
            ),
            const SizedBox(height: 32),
            const Text('Correct Option'),
            Row(
                children: options
                    .map((option) => [
                          Radio<String>(
                            value: option,
                            groupValue: _question['correct'] as String,
                            onChanged: (v) =>
                                setState(() => _question['correct'] = v!),
                          ),
                          Text(option),
                          const SizedBox(width: 16)
                        ])
                    .expand((w) => w)
                    .toList()),
            const SizedBox(height: 32),
            ...options
                .asMap()
                .entries
                .map((entry) => [
                      TextFormField(
                        controller: _optionCtrls[entry.key],
                        decoration: InputDecoration(
                            labelText: 'Option ${entry.value}*'),
                        validator: (v) => v!.isEmpty
                            ? 'Please fill in Option ${entry.value}'
                            : null,
                      ),
                      const SizedBox(height: 32),
                    ])
                .expand((w) => w),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _question['value'] = _questionCtrl.text;
                    _question['options'] = _optionCtrls.asMap().entries.map(
                      (entry) {
                        return {
                          'index': options[entry.key],
                          'value': entry.value.text
                        };
                      },
                    );
                    if (kDebugMode) {
                      print(_question);
                    }
                    showSnackbar(
                      success: true,
                      text: 'Question updated successfully.',
                    );
                  } else {
                    showSnackbar(
                      success: false,
                      text: 'Please fill all the required fields.',
                    );
                  }
                },
                child: const Text('Update'),
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
