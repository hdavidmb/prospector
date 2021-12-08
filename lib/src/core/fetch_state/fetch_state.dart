import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_state.freezed.dart';

// TODO: unify all fetchable objects state
@freezed
class FetchState with _$FetchState {
  const FetchState._();
  const factory FetchState.initial() = Initial;
  const factory FetchState.fetching() = Fetching;
  const factory FetchState.ready() = Ready;
  const factory FetchState.error() = Error;
}

extension FetchStateX on FetchState {
  bool get isInitial => this == const FetchState.initial();
  bool get isFetching => this == const FetchState.fetching();
  bool get isReady => this == const FetchState.ready();
  bool get isError => this == const FetchState.error();
}
