import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/shared_prefs/shared_prefs_provider.dart';
import 'import_contacts_menu_notifier.dart';

final imporContactsMenuProvider = ChangeNotifierProvider<ImportContactsMenuNotifier>((ref) {
  final _prefs = ref.watch(userSharedPrefsProvider);
    return ImportContactsMenuNotifier(prefs: _prefs, read: ref.read);
});