import 'dart:io';

import 'package:dartz/dartz.dart';

import '../sources/source_image.dart';

abstract class IImagesPicker {
  Future<Option<File>> getImage({required SourceImage source});
}
