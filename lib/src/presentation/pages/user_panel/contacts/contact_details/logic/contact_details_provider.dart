import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'contact_details_notifier.dart';

final contactDetailsProvider = Provider<ContactDetailsNotifier>((ref) {
  return ContactDetailsNotifier(read: ref.read);
});
