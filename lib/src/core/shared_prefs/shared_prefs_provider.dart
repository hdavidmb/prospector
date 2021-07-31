
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_prefs.dart';

final userSharedPrefsProvider =
    Provider<UserSharedPreferences>((ref) => UserSharedPreferences());