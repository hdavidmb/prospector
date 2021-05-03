import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prospector/src/features/images/data/image_picker_repository.dart';
import 'package:prospector/src/features/images/domain/interface/i_images_picker.dart';
import 'package:prospector/src/features/images/domain/use_cases/get_image.dart';

// * Repository
final imagePrickerRepository = Provider<IImagesPicker>((ref) {
  final ImagePicker imagePickerInstance = ImagePicker();
    return ImagePickerRepository(picker: imagePickerInstance);
});

// * Use cases
final getImage = Provider<GetImage>((ref) {
  final _imagesPickerRepository = ref.watch(imagePrickerRepository);
    return GetImage(imagesPickerRepository: _imagesPickerRepository);
});