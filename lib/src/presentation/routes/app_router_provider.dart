import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/routes/app_router.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
