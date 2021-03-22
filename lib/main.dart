import 'package:flutter/material.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';
import 'package:provider/provider.dart';

import 'src/presentation/my_app.dart';
import 'src/presentation/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserSharedPreferences();
  await prefs.initPrefs();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider(prefs))
      ],
      child: MyApp(),
    ),
  );
}
