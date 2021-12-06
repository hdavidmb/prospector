import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/failures/import_contacts_failure.dart';

part 'import_contacts_state.freezed.dart';

@freezed
class ImportContactsState with _$ImportContactsState{
  const factory ImportContactsState.initial() = Initial;
  const factory ImportContactsState.fetching() = Fetching;
  const factory ImportContactsState.error(ImportContactsFailure failure) = Error;
  const factory ImportContactsState.ready() = Ready;
}