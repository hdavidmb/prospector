import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_failure.freezed.dart';

@freezed
class StorageFailure with _$StorageFailure{
  const factory StorageFailure.noConnection() = NoConnection;
  const factory StorageFailure.invalidFormat() = InvalidFormat;
  const factory StorageFailure.serverError() = ServerError;
}