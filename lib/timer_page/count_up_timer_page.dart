import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_manager/task_page/task_setting.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

class CountUpTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CountUpTimerPage(),
      ),
    );
  }

  @override
  _CountUpTimerPageState createState() => _CountUpTimerPageState();
}

class _CountUpTimerPageState extends State<CountUpTimerPage> {
  final _isHours = true;
  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  bool _isRunning = false; // Stopwatch running state

  List<String> tasks = [];
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    // Firestoreからタスクを取得する
    _fetchTasksFromFirestore();
  }

  Future<void> _fetchTasksFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      setState(() {
        tasks.add(doc['taskName']);
        if (dropdownValue.isEmpty) {
          dropdownValue = tasks.first;
        }
      });
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FightManager'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('タスク設定'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskSettingPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                isExpanded: true, // これを追加
                items: tasks.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return tasks.map<Widget>((String value) {
                    return Center(
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Text(
                    displayTime,
                    style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isRunning) {
                      _stopWatchTimer.onStopTimer();
                    } else {
                      _stopWatchTimer.onStartTimer();
                    }
                    _isRunning = !_isRunning;
                  });
                },
                child: Text(_isRunning ? 'タスク終わり' : 'タスク始め'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stopWatchTimer.onResetTimer();
                  });
                },
                child: Text('リセット'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
