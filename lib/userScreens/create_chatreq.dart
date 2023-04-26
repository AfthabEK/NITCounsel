import 'package:flutter/material.dart';
import '../widgets/my_filter_chip.dart';
import '../widgets/filter_chip_data.dart';
import 'user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

List<String> tags = [];

class _MyFormState extends State<MyForm> {
  final double spacing = 8;

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  bool? _listTileCheckBox = false;
  List<FilterChipData> filterChips = FilterChips.all;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Text(
                "Create Chat Request",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(height: 10.0),
              const Text(
                  "Fill all the details regarding your request. No field should be left empty."),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                        myController: _productController,
                        fieldName: "Title",
                        myIcon: Icons.propane_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    const SizedBox(height: 10.0),
                    MyTextField(
                        myController: _productDesController,
                        fieldName: "Description",
                        myIcon: Icons.description_outlined,
                        prefixIconColor: Colors.deepPurple.shade300),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Select appropriate tags: ",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 24),
                    ),
                    Wrap(
                      runSpacing: spacing,
                      spacing: spacing,
                      children: filterChips
                          .map(
                            (filterChip) => FilterChip(
                              label: Text(filterChip.label),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: filterChip.color,
                              ),
                              backgroundColor:
                                  filterChip.color.withOpacity(0.1),
                              onSelected: (isSelected) => setState(() {
                                filterChips = filterChips.map((otherChip) {
                                  return filterChip == otherChip
                                      ? otherChip.copy(isSelected: isSelected)
                                      : otherChip;
                                }).toList();
                              }),
                              selected: filterChip.isSelected,
                              checkmarkColor: filterChip.color,
                              selectedColor: filterChip.color.withOpacity(0.25),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20.0),
                    myBtn(context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildFilterChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: filterChips
            .map((filterChip) => FilterChip(
                  label: Text(filterChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: filterChip.color,
                  ),
                  backgroundColor: filterChip.color.withOpacity(0.1),
                  onSelected: (isSelected) => setState(() {
                    filterChips = filterChips.map((otherChip) {
                      return filterChip == otherChip
                          ? otherChip.copy(isSelected: isSelected)
                          : otherChip;
                    }).toList();
                  }),
                  selected: filterChip.isSelected,
                  checkmarkColor: filterChip.color,
                  selectedColor: filterChip.color.withOpacity(0.25),
                ))
            .toList(),
      );

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.of(context).pop();
        filterChips.forEach((element) {
          if (element.isSelected) {
            tags.add(element.label);
          }
        });
        String description = _productDesController.text;
        String title = _productController.text;
        String user_id = FirebaseAuth.instance.currentUser!.uid;
        createChatRequest(user_id, title, description, tags);
      },
      child: Text(
        "Create Chat Request".toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else
          null;
      },
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
    );
  }
}

Future<void> createChatRequest(
    String user_id, String title, String description, List<String> tags) async {
  try {
    await FirebaseFirestore.instance.collection('chatRequests').add({
      'user_id': user_id,
      'title': title,
      'description': description,
      'tags': tags,
      'status': 'pending', // set initial status as pending
      'createdAt': DateTime.now(), // set creation timestamp
      'acceptedBy': '',
    });
    tags.clear();
    print('Chat request created successfully');
  } catch (e) {
    print('Failed to create chat request: $e');
  }
}
