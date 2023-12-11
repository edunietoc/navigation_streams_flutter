import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom_context_event.dart';
import '../../models/navigation_event.dart';
import '../../providers/providers.dart';
import '../../utils/screen_widget.dart';
import 'first_screen_vm.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) => ScreenWidget(
        viewModelProvider: firstScreenViewModelProvider,
        customContextEventCallback: onReceiveCustomEvents,
        child: (BuildContext context) => Scaffold(
          body: Center(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                FirstScreenViewModel viewModel =
                    ref.watch(firstScreenViewModelProvider);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // First screen

                    ElevatedButton(
                      onPressed: viewModel.someAsyncMethod,
                      child: const Text('some async method'),
                    ),

                    ElevatedButton(
                      onPressed: viewModel.showDialog,
                      child: const Text('push here to show dialog'),
                    ),

                    // Second screen
                    ElevatedButton(
                      onPressed: () => viewModel.navigate(
                        PushNavigationEvent(route: '/second'),
                      ),
                      child: const Text('Second screen'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}

void onReceiveCustomEvents(CustomContextEvent event, BuildContext context) {
  if (event is DialogEvent) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: <Widget>[
              Text(event.title),
              SizedBox(height: 20),
              Text(event.description),
            ],
          ),
        ),
      ),
    );
  }
}
