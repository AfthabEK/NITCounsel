import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({super.key});

  @override
  State<EditQuestion> createState() => EditQuestionState();
}

class EditQuestionState extends State<EditQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 163, 221),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              //height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Questions",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "1. Where is CZ located?\n   a. Near basketball court\n   b. Inside OAT\n   c. Above Audtorium\n   d. None of the above",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "2. How many hostels are there?\n     a. 7\n     b. 8\n     c. 9\n     d. 10",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "3. Cultural fest of NITC\n  a. Tathva\n  b. Incident\n  c. Ragam\n  d. Vibes",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "     4. Learning management system of NITC\n          a. Dribble\n          b. Eduserver\n          c. NITage\n          d. 10",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "5. How many hostels are there?\n     a. 7\n     b. 8\n     c. 9\n     d. 10",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        )),
                  ]),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 211, 194, 194)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Add Questions",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
