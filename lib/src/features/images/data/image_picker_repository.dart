import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/interface/i_images_picker.dart';
import '../domain/sources/source_image.dart';

class ImagePickerRepository implements IImagesPicker {
  final ImagePicker picker;
  ImagePickerRepository({
    required this.picker,
  });

  @override
  Future<Option<File>> getImage({required SourceImage source}) async {
    final ImageSource repoSource = source.when(
      gallery: () => ImageSource.gallery,
      camera: () => ImageSource.camera,
    );
    final pickedFile = await picker.pickImage(
        source: repoSource, maxHeight: 200.0, maxWidth: 200.0);
    if (pickedFile != null) {
      return some(File(pickedFile.path));
    } else {
      return none();
    }
  }
}
