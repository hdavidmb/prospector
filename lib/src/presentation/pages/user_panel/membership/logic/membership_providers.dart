import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/logic/membership_notifier.dart';

// TODO: final selectedPackageIndexProvider = StateProvider<int>((ref) => 1);

final membershipNotifierProvider =
    ChangeNotifierProvider<MembershipNotifier>((ref) {
  return MembershipNotifier(read: ref.read);
});
