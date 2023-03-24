import 'package:flutter/material.dart';
import 'package:todo/screens/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddpage, label: Text('Add Todo')),
    );
  }

  void navigateToAddpage() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    Navigator.push(context, route);
  }
}
