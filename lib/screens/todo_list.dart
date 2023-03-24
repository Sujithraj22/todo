import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/screens/add_page.dart';
import 'package:http/http.dart' as http;
import 'package:todo/services/todo_service.dart';
import 'package:todo/utils/snackbar_helper.dart';

import '../utils/snackbar_helper.dart';
import '../widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(

            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'];
                  return TodoCard(
                    index: index,
                    deleteById: deleteById,
                    navigateEdit: navigateToEditPage,
                    item: item,
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddpage, label: Text('Add Todo')),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),);
   await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }


  Future<void> navigateToAddpage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    //delete the item

    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      //delete item from the list
      final filtered = items.where((element) => element ['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      //show error
      showErrorMessage(context, message: 'Deletion Failed');
    }
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }

    setState(() {
      isLoading = false;
    });
  }



}
