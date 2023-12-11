import 'package:flutter/material.dart';

import '../../models/navigation_event.dart';
import '../../utils/status_notifier.dart';

class SecondScreenViewModel extends StatusNotifier {
  Future<void> makeActionThenPop() async {
    navigate(PopNavigationEvent(result: 'Hello from second screen'));
  }

  void goToScreen(
    BuildContext context,
    String route, [
    Map<String, dynamic>? args,
  ]) {
    Navigator.pushNamed(context, route, arguments: args);
  }
}
