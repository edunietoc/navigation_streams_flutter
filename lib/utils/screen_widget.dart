import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/custom_context_event.dart';
import 'navigation_listener.dart';
import 'status_notifier.dart';

class ScreenWidget extends ConsumerWidget {
  const ScreenWidget({
    required this.child,
    required this.viewModelProvider,
    this.customContextEventCallback,
    super.key,
  });

  final Widget Function(BuildContext) child;
  final ChangeNotifierProvider<StatusNotifier> viewModelProvider;
  final void Function(CustomContextEvent, BuildContext)?
      customContextEventCallback;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StatusNotifier notifier = ref.watch(viewModelProvider);
    return NavigationListener(
      stream: notifier.navigationStream,
      sink: notifier.navigationSink,
      customContextEventCallback: customContextEventCallback,
      child: child(context),
    );
  }
}
