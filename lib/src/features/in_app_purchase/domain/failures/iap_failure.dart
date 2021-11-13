import 'package:freezed_annotation/freezed_annotation.dart';

part 'iap_failure.freezed.dart';

@freezed
class IAPFailure with _$IAPFailure {
  const IAPFailure._();
  const factory IAPFailure.serverError() = ServerError;
  const factory IAPFailure.noConnection() = NoConnection;
}
