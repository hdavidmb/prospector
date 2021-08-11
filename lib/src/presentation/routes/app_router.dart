import 'package:auto_route/auto_route.dart';

import '../pages/auth/register/register_page.dart';
import '../pages/auth/sign_in/sign_in_page.dart';
import '../pages/splash/splash_screen_page.dart';
import '../pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart';
import '../pages/user_panel/contacts/contact_details/contact_details_page.dart';
import '../pages/user_panel/home/home_page.dart';

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
    CupertinoRoute(page: ContactDetailsPage),
    CupertinoRoute(page: ContactAddEditPage),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
