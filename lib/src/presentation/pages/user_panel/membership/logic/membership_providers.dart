import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'membership_notifier.dart';

final membershipNotifierProvider =
    ChangeNotifierProvider<MembershipNotifier>((ref) {
  return MembershipNotifier(read: ref.read);
});
