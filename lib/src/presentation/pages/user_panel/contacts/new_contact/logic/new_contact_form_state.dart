import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';

part 'new_contact_form_state.freezed.dart';

@freezed
class NewContactFormState with _$NewContactFormState {
  const factory NewContactFormState({
    required String name,
    required String phone,
    required String whatsapp,
    required List<String> phones,
    required String location,
    required String gender,
    required String status,
    required List<String> tags,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<DatabaseFailure> failureOption, //TODO change to Option<Either<DatabaseFailure, Unit>>
  }) = _NewContactFormState;

  factory NewContactFormState.initial() => NewContactFormState(
        name: '',
        phone: '',
        whatsapp: '',
        phones: [],
        location: '',
        gender: '',
        status: '',
        tags: [],
        isSubmitting: false,
        showErrorMessages: false,
        failureOption: none(),
      );
}
