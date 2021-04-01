import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';
import 'package:prospector/src/presentation/theme/theme_notifier.dart';

final userSharedPrefsProvider = Provider<UserSharedPreferences>((ref) => UserSharedPreferences());

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier(ref.read(userSharedPrefsProvider)));