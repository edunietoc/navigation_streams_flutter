import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../utils/screen_widget.dart';
import 'second_screen_vm.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) => ScreenWidget(
        viewModelProvider: secondScreenViewModelProvider,
        child: (BuildContext context) => Scaffold(
          body: Center(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                SecondScreenViewModel viewModel =
                    ref.watch(secondScreenViewModelProvider);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // First screen

                    ElevatedButton(
                      onPressed: viewModel.makeActionThenPop,
                      child: const Text('pop here with result'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
