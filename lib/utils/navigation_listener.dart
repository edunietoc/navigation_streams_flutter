import 'dart:async';

import 'package:flutter/material.dart';

import '../models/custom_context_event.dart';
import '../models/navigation_base.dart';
import '../models/navigation_event.dart';
import '../models/pop_event.dart';

class NavigationListener extends StatefulWidget {
  const NavigationListener({
    required this.child,
    required this.stream,
    required this.sink,
    this.customContextEventCallback,
    super.key,
  });

  final Widget child;
  final Stream<BaseNavigationEvent> stream;
  final Sink<BaseNavigationEvent> sink;
  final void Function(CustomContextEvent event, BuildContext context)?
      customContextEventCallback;

  @override
  State<NavigationListener> createState() => _NavigationListenerState(
        child: child,
        stream: stream,
        sink: sink,
      );
}

class _NavigationListenerState extends State<NavigationListener> {
  _NavigationListenerState({
    required this.child,
    required this.stream,
    required this.sink,
  });
  Widget child;
  final Stream<BaseNavigationEvent> stream;
  final Sink<BaseNavigationEvent> sink;
  StreamSubscription<BaseNavigationEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = stream.listen(_onReceiveEvent);
  }

  Future<void> _onReceiveNavigationEvent(BaseNavigationEvent event) async {
    dynamic result;

    if (event is PushNavigationEvent) {
      result = await Navigator.pushNamed(
        context,
        event.route,
        arguments: event.arguments,
      );
    } else if (event is PushReplacementNavigationEvent) {
      result = await Navigator.pushReplacementNamed(
        context,
        event.route,
        arguments: event.arguments,
      );
    } else if (event is NavigationEventPushRemoveUntil) {
      result = await Navigator.pushNamedAndRemoveUntil(
        context,
        event.route,
        event.predicate,
      );
    } else if (event is PopNavigationEvent) {
      Navigator.pop(context, event.result);
    } else if (event is PopUntilNavigationEvent) {
      Navigator.popUntil(context, event.predicate);
    }

    if (result != null) {
      sink.add(PopResultEvent(result: result));
    }
  }

  Future<void> _onReceiveEvent(BaseNavigationEvent event) async {
    _onReceiveNavigationEvent(event);
    if (event is CustomContextEvent &&
        widget.customContextEventCallback != null) {
      widget.customContextEventCallback!(event, context);
    } //create more conditions depending on your needs
  }

  @override
  void didUpdateWidget(covariant NavigationListener oldWidget) {
    if (oldWidget.child != widget.child) {
      child = widget.child;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => child;
}
