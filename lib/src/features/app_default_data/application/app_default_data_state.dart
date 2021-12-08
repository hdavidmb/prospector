import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_default_data_state.freezed.dart';

//TODO: unify fetch state
@freezed
class AppDefaultDataState with _$AppDefaultDataState {
  const factory AppDefaultDataState.initial() = Initial;
  const factory AppDefaultDataState.ready() = Ready;
  const factory AppDefaultDataState.error() = Error;
}
