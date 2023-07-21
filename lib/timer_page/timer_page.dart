import 'package:fight_manager/timer_page/count_down_timer_page.dart';
import 'package:fight_manager/timer_page/count_up_timer_page.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.all(4),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  CountUpTimerPage.navigatorPush(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'タイマー',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: Colors.pinkAccent,
            //       padding: const EdgeInsets.all(4),
            //       shape: const StadiumBorder(),
            //     ),
            //     onPressed: () {
            //       CountDownTimerPage.navigatorPush(context);
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 16),
            //       child: Text(
            //         'Count Down Timer',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
