import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactions_state.freezed.dart';

@freezed
class InteractionsState with _$InteractionsState {
  const InteractionsState._();
  const factory InteractionsState.initial() = Initial;
  const factory InteractionsState.fetching() = Fetching;
  const factory InteractionsState.ready() = Ready;
  const factory InteractionsState.error() = Error;
}
