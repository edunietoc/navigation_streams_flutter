import 'package:flutter/material.dart';

import 'navigation_base.dart';

class PushNavigationEvent implements BaseNavigationEvent {
  const PushNavigationEvent({
    required this.route,
    this.arguments,
  });

  final String route;
  final Object? arguments;
}

class PushReplacementNavigationEvent implements BaseNavigationEvent {
  const PushReplacementNavigationEvent({
    required this.route,
    this.arguments,
  });

  final String route;
  final Object? arguments;
}

class NavigationEventPushRemoveUntil extends PushNavigationEvent {
  NavigationEventPushRemoveUntil({
    required this.predicate,
    required super.route,
    super.arguments,
  });

  final bool Function(Route<dynamic>) predicate;
}

class PopNavigationEvent implements BaseNavigationEvent {
  PopNavigationEvent({
    this.result,
  });

  final dynamic result;
}

class PopUntilNavigationEvent implements BaseNavigationEvent {
  PopUntilNavigationEvent({
    required this.predicate,
  });

  final bool Function(Route<dynamic>) predicate;
}
