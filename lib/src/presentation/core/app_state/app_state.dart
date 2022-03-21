import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = Initial;
  const factory AppState.unauthenticatedReady() = UnathenticatedReady;
  const factory AppState.authenticatedReady() = AthenticatedReady;
  const factory AppState.error() = Error;
}
