import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_home_state.freezed.dart';

@freezed
abstract class MyHomePageState with _$MyHomePageState {
  const factory MyHomePageState({
    required int counter,
  }) = _MyHomePageState;
}
