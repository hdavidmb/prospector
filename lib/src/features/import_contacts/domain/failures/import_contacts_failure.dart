import 'package:freezed_annotation/freezed_annotation.dart';

part 'import_contacts_failure.freezed.dart';

@freezed
class ImportContactsFailure with _$ImportContactsFailure {
  const factory ImportContactsFailure.accessDenied() = AccessDenied;
  const factory ImportContactsFailure.serverError() = ServerError;
  const factory ImportContactsFailure.noUserAuthenticated() =
      NoUserAuthenticated;
}
