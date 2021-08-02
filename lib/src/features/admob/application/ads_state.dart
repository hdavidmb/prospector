import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_state.freezed.dart';

@freezed
class AdsState with _$AdsState {
  const factory AdsState.initial() = Initial;
  const factory AdsState.loading() = Loading;
  const factory AdsState.loaded() = Loaded;
  const factory AdsState.error() = Error;
}
