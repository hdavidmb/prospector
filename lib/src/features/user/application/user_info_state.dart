import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_state.freezed.dart';

@freezed
class UserInfoState with _$UserInfoState{
  const factory UserInfoState.initial() = Initial;
  const factory UserInfoState.fetching() = Fetching;
  const factory UserInfoState.ready() = Ready;
  const factory UserInfoState.error() = Error;
}