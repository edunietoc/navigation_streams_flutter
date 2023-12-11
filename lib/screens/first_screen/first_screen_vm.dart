import 'package:flutter/material.dart';

import '../../models/custom_context_event.dart';
import '../../models/navigation_event.dart';
import '../../models/pop_event.dart';
import '../../utils/status_notifier.dart';

class DialogEvent extends CustomContextEvent {
  DialogEvent({
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
}

class FirstScreenViewModel extends StatusNotifier {
  Future<void> someAsyncMethod() async {
    await Future<void>.delayed(Duration(seconds: 3));
    navigate(PushNavigationEvent(route: '/second'));
  }

  @override
  void onPopEvent(PopResultEvent event) {
    print('onPopEvent: ${event.result}');
  }

  void showDialog() {
    sendCustomContextEvent(
      DialogEvent(
        title: 'Dialog title',
        description: 'Dialog description',
      ),
    );
  }

  Future<void> actionThenGoToSecondScreen(BuildContext context) async {
    await Future<void>.delayed(Duration(seconds: 3));
    Navigator.pushNamed(context, '/second');
  }
}
