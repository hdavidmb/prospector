import 'dart:io';

import 'package:dartz/dartz.dart';

import '../interface/i_images_picker.dart';
import '../sources/source_image.dart';

class GetImage {
  final IImagesPicker imagesPickerRepository;
  GetImage({
    required this.imagesPickerRepository,
  });

  Future<Option<File>> call({required SourceImage source}) => imagesPickerRepository.getImage(source: source);
}
