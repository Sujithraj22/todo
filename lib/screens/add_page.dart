import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: 'Title'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(hintText: 'Description'),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              submitData;
            },
            child: Text('Submit')),
      ]),
    );
  }

  //Form Handling

  Future<void> submitData() async {
    // Get the data from form

    final title = titleController;
    final description = descriptionController;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    // Submit data to the server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // Show success or fail message based on status
    print('hello');
    print(response.statusCode);
    print(response.body);
    print(title);
  }
}
