import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'src/app.dart';
import 'src/core/private/private_keys.dart';
import 'src/core/shared_prefs/shared_prefs.dart';
import 'src/features/app_default_data/domain/entities/status_entity.dart';
import 'src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'src/features/user/domain/entity/user_entity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  final prefs = UserSharedPreferences();
  await prefs.initPrefs();
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
  await Hive.initFlutter();
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(SubscriptionAdapter());
  Hive.registerAdapter(UserEntityAdapter());

  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup(PrivateKeys.revenueCatPublicSDKKey);

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
