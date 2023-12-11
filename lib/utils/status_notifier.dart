import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../models/custom_context_event.dart';
import '../models/navigation_base.dart';
import '../models/pop_event.dart';

class StatusNotifier extends ChangeNotifier {
  StatusNotifier() {
    init();
  }

  void init() {
    _navigationSubscription =
        navigationStream.listen((BaseNavigationEvent event) {
      if (event is PopResultEvent) {
        onPopEvent(event);
      }
    });
  }

  bool _disposed = false;

  final StreamController<BaseNavigationEvent> _navigationStreamController =
      StreamController<BaseNavigationEvent>.broadcast();

  Stream<BaseNavigationEvent> get navigationStream =>
      _navigationStreamController.stream;

  Sink<BaseNavigationEvent> get navigationSink =>
      _navigationStreamController.sink;

  StreamSubscription<BaseNavigationEvent>? _navigationSubscription;

  void navigate(BaseNavigationEvent event) {
    _navigationStreamController.add(event);
  }

  void sendCustomContextEvent(CustomContextEvent event) {
    _navigationStreamController.add(event);
  }

  @visibleForOverriding
  void onPopEvent(PopResultEvent event) {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _navigationStreamController.close();
    _navigationSubscription?.cancel();
    super.dispose();
  }
}
