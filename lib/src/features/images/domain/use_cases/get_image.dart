import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/images/domain/interface/i_images_picker.dart';
import 'package:prospector/src/features/images/domain/sources/source_image.dart';

class GetImage {
  final IImagesPicker imagesPickerRepository;
  GetImage({
    required this.imagesPickerRepository,
  });

  Future<Option<File>> call({required SourceImage source}) => imagesPickerRepository.getImage(source: source);
}
