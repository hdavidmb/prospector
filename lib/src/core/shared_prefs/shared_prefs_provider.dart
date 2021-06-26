
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';

final userSharedPrefsProvider =
    Provider<UserSharedPreferences>((ref) => UserSharedPreferences());