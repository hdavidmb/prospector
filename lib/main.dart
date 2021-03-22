import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';

import 'src/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = UserSharedPreferences();
  await prefs.initPrefs();
  runApp(
    ProviderScope(child: MyApp(),),
  );
}
