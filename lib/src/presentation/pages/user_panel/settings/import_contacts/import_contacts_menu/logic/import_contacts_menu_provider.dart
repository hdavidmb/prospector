import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts_menu/logic/import_contacts_menu_notifier.dart';

final imporContactsMenuProvider = ChangeNotifierProvider<ImportContactsMenuNotifier>((ref) {
  final _prefs = ref.watch(userSharedPrefsProvider);
    return ImportContactsMenuNotifier(prefs: _prefs, read: ref.read);
});