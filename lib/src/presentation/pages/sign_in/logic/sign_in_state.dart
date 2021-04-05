import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState{
  const factory SignInState.initial() = Initial;
  const factory SignInState.loading() = Loading;
}