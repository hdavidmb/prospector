import 'package:auto_route/auto_route.dart';
import 'package:prospector/src/presentation/pages/auth/register/register_page.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:prospector/src/presentation/pages/splash/splash_screen_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/home_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashScreenPage, initial: true),
    CustomRoute(
        page: HomePage,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: '/home'),
    CustomRoute(
        page: SignInPage,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: '/sign-in'),
    CustomRoute(
        page: RegisterPage,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: '/register'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
