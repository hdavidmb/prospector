import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/database/database_failures/database_failure.dart';

part 'contact_form_state.freezed.dart';

@freezed
class ContactFormState with _$ContactFormState {
  const factory ContactFormState({
    required String name,
    required String phone,
    required String whatsapp,
    required List<String> phones,
    required String location,
    required String gender,
    required List<String> tags,
    required String status,
    required File? pickedImage,
    required bool isSubmitting,
    required bool showErrorMessages,
    required bool deleted,
    required Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption,
  }) = _ContactFormState;

  factory ContactFormState.initial() => ContactFormState(
        name: '',
        phone: '',
        whatsapp: '',
        phones: [],
        location: '',
        gender: '',
        tags: [],
        status: '',
        pickedImage: null,
        isSubmitting: false,
        showErrorMessages: false,
        deleted: false,
        failureOrSuccesOption: none(),
      );
}
