// ignore_for_file: always_specify_types

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/first_screen/first_screen_vm.dart';
import '../screens/second_screen/second_screen_vm.dart';

final firstScreenViewModelProvider =
    ChangeNotifierProvider<FirstScreenViewModel>(
  (ref) => FirstScreenViewModel(),
);

final secondScreenViewModelProvider =
    ChangeNotifierProvider<SecondScreenViewModel>(
  (ref) => SecondScreenViewModel(),
);
