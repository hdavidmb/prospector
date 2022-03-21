import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_image.freezed.dart';

@freezed
class SourceImage with _$SourceImage {
  const factory SourceImage.gallery() = Gallery;
  const factory SourceImage.camera() = Camera;
}
