import 'package:flutter/material.dart';  // Importing the Flutter Material package for UI components
import 'package:sqflite/sqflite.dart';  // Importing sqflite package for SQLite database operations
import 'package:fluttertoast/fluttertoast.dart';  // Importing Fluttertoast package for displaying toasts
import 'package:path/path.dart' as path;  // Importing path package with an alias "path"
// ignore: depend_on_referenced_packages

import '../models/Task.dart';  // Importing the Task model from a custom location

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});
  // Declaring a StatefulWidget for the Tasks page
  @override
  State<TasksPage> createState() => _TasksPageState();  // Creating the state for the Tasks page
}

// ignore: duplicate_ignore, 
class _TasksPageState extends State<TasksPage> {  // State class for the Tasks page
  List<Task> tasks = [];  // List to store the tasks retrieved from the database
 

    void initSate() {  // A typo here. It should be "initState" instead of "initSate"
    super.initState();
    _loadTasksFromDB();  // Loading tasks from the database when the state is initialized
  }

  void _loadTasksFromDB() async {  // Function to load tasks from the SQLite database
    final database = await openDatabase(
      path.join(await getDatabasesPath(), 'tasks.db'),  // Getting the database path and opening the 'tasks.db' database
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,description TEXT, isCompleted INTEGER)");
      },  // Creating the 'tasks' table if it doesn't exist
      version: 1,
    );
    final List<Map<String, dynamic>> maps = await database.query('tasks');  // Fetching all rows from the 'tasks' table
    setState(() {
      tasks = List.generate(maps.length, (index) => Task(  // Generating Task objects from the database rows
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        isCompleted: maps[index]['isCompleted'],
      ));
    });
  }

  void saveTaskToDB(Task task) async {  // Function to save a task to the SQLite database
    final database = await openDatabase(
      path.join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) => {
        db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,description TEXT, isCompleted INTEGER)"),
      },
      version: 1,       
    );  // Opening the 'tasks.db' database
    await database.insert('tasks', task as Map<String, Object?>, conflictAlgorithm: ConflictAlgorithm.replace);  // Inserting the task into the 'tasks' table
    Fluttertoast.showToast(msg: "Task Added Successfully");  // Displaying a toast to indicate task addition
  }

  void showAddTaskDialog() {  // Function to show an add task dialog
    showDialog(
      context: context,
      builder: (context) {
        String title = "";
        String description = "";
        // ignore: unused_local_variable
        int id;
        return AlertDialog(
          title:  const Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration:const  InputDecoration(labelText: "Title"),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration:const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:  const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newTask = (title: title, description: description, isCompleted: 'isCompleted',); // Creating a new Task object
                setState(() {
                  tasks.add(newTask as Task);  // Adding the new task to the list of tasks
                  Navigator.of(context).pop();  // Closing the dialog
                });
              },
              child:const Text("Save"),
            )
          ],
        );
      },
    );
  }

  Widget _buildList() { // Function to build the ListView of tasks
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: Checkbox(
                        onChanged: (value) {
              setState(() {
                tasks[index].isCompleted = value as  bool; // Updating the completion status of the task
              });
            }, value: null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {  // Widget build method for the Tasks page
    return Scaffold(
      appBar: AppBar(title:const Text("Tasks")),  // App bar with the title "Tasks"
      body: _buildList(),  // Displaying the ListView of tasks
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,  // Showing the add task dialog when the FloatingActionButton is pressed
        child:const Icon(Icons.add),  // Icon for the FloatingActionButton
      ),
    );
  }
}
