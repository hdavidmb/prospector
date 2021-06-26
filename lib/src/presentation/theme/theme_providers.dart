import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs_provider.dart';
import 'package:prospector/src/presentation/theme/theme_notifier.dart';

export 'package:prospector/src/presentation/theme/theme_constants.dart';

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>(
    (ref) => ThemeNotifier(ref.watch(userSharedPrefsProvider)));
