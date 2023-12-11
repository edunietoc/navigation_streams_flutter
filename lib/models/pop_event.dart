import 'navigation_base.dart';

class PopResultEvent extends BaseNavigationEvent {
  PopResultEvent({
    required this.result,
  });
  final dynamic result;
}
