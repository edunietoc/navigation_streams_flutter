import 'package:flutter/material.dart';

import '../screens/first_screen/first_screen.dart';
import '../screens/second_screen/second_screen.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  '/first': (BuildContext context) => const FirstScreen(),
  '/second': (BuildContext context) => const SecondScreen(),
};
