import 'package:auto_route/auto_route.dart';
import 'package:prospector/src/presentation/pages/splash/splash_screen_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/home_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashScreenPage, initial: true),
    CustomRoute(page: HomePage, transitionsBuilder: TransitionsBuilders.fadeIn)
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
