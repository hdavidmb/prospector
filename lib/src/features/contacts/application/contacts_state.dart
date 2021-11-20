import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_state.freezed.dart';

// TODO: unify all fetchable objects state
@freezed
class ContactsState with _$ContactsState {
  const factory ContactsState.initial() = Initial;
  const factory ContactsState.fetching() = Fetching;
  const factory ContactsState.ready() = Ready;
  const factory ContactsState.error() = Error;
}
