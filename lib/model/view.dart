import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/state/my_home_state.dart';

class MyHomePageStateNotifier extends StateNotifier<MyHomePageState> {
  MyHomePageStateNotifier() : super(const MyHomePageState(counter: 0));

  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }
}
