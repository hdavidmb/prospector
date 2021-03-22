import 'package:flutter/material.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';

import 'src/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserSharedPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}
