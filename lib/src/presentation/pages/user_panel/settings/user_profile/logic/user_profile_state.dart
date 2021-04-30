import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';

part 'user_profile_state.freezed.dart';

@freezed
abstract class UserProfileState with _$UserProfileState{
  const factory UserProfileState.initial() = Initial;
  const factory UserProfileState.submitting() = Submitting;
  const factory UserProfileState.error(UserInfoFailure failure) = Error;
  const factory UserProfileState.reloginError(AuthFailure failure) = ReloginError;
}