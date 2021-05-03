import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_failure.freezed.dart';

@freezed
class UserInfoFailure with _$UserInfoFailure{
  const factory UserInfoFailure.noConnection() = NoConnection;
  const factory UserInfoFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory UserInfoFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination;
  const factory UserInfoFailure.serverError() = ServerError;
}