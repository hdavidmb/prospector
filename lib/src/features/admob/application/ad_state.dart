import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_state.freezed.dart';

@freezed
class AdState with _$AdState {
  const factory AdState.initial() = Initial;
  const factory AdState.loading() = Loading;
  const factory AdState.loaded() = Loaded;
  const factory AdState.error() = Error;
}

extension AdStateX on AdState {
  bool get isInitial => this == const AdState.initial();
  bool get isLoading => this == const AdState.loading();
  bool get isLoaded => this == const AdState.loaded();
  bool get isError => this == const AdState.error();
}
