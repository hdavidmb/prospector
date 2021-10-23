import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_state.freezed.dart';

@freezed
class EventsState with _$EventsState {
  const EventsState._();
  const factory EventsState.initial() = Initial;
  const factory EventsState.fetching() = Fetching;
  const factory EventsState.ready() = Ready;
  const factory EventsState.error() = Error;
}
