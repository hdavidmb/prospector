import 'package:auto_route/auto_route.dart';

import '../pages/auth/register/register_page.dart';
import '../pages/auth/sign_in/sign_in_page.dart';
import '../pages/splash/splash_screen_page.dart';
import '../pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart';
import '../pages/user_panel/contacts/contact_details/contact_details_page.dart';
import '../pages/user_panel/home/home_page.dart';
import '../pages/user_panel/settings/change_email/change_email_page.dart';
import '../pages/user_panel/settings/change_password/change_password_page.dart';
import '../pages/user_panel/settings/country_code/country_code_page.dart';
import '../pages/user_panel/settings/import_contacts/import_contacts/import_contacts_page.dart';
import '../pages/user_panel/settings/import_contacts/import_contacts_menu/import_contacts_menu_page.dart';
import '../pages/user_panel/settings/import_contacts/imported_contacts/imported_contacts_page.dart';
import '../pages/user_panel/settings/tags_settings/tags_settings_page.dart';
import '../pages/user_panel/settings/user_profile/user_profile_page.dart';

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
    CupertinoRoute(page: UserProfilePage),
    CupertinoRoute(page: ChangeEmailPage),
    CupertinoRoute(page: ChangePasswordPage),
    CupertinoRoute(page: ImportContactsMenuPage),
    CupertinoRoute(page: TagsSettingsPage),
    CupertinoRoute(page: ImportedContactsPage),
    CupertinoRoute(page: ImportContactsPage),
    CupertinoRoute(page: CountryCodePage),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
