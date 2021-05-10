import 'package:freezed_annotation/freezed_annotation.dart';

part 'tags_state.freezed.dart';

@freezed
class TagsState with _$TagsState{
  const factory TagsState.initial() = Initial;
  const factory TagsState.fetching() = Fetching;
  const factory TagsState.ready() = Ready;
  const factory TagsState.error() = Error;
}