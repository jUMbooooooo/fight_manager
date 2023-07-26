import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskSettingPage extends StatefulWidget {
  const TaskSettingPage({super.key});

  @override
  _TaskSettingPageState createState() => _TaskSettingPageState();
}

class _TaskSettingPageState extends State<TaskSettingPage> {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク設定"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: "新しいタスク"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_taskController.text.isNotEmpty) {
                  // Firestoreにタスクを追加する
                  await FirebaseFirestore.instance
                      .collection('tasks')
                      .add({'taskName': _taskController.text});

                  _taskController.clear();
                }
              },
              child: const Text("タスクを追加"),
            )
          ],
        ),
      ),
    );
  }
}
