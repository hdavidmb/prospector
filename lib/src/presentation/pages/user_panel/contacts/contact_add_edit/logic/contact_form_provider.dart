import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/images/application/image_picker_providers.dart';
import '../../../../../../features/storage/application/storage_providers.dart';
import 'contact_form_state.dart';
import 'contact_form_state_notifier.dart';

final contactFormProvider =
    StateNotifierProvider<ContactFormStateNotifier, ContactFormState>(
        (ref) {
          final _getImage = ref.watch(getImage);
          final _uploadContactImage = ref.watch(uploadContactImage);
  return ContactFormStateNotifier(
    uploadContactImage: _uploadContactImage,
    getImage: _getImage,
    read: ref.read,
  );
});
