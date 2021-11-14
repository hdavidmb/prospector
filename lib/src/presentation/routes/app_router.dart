import 'package:auto_route/auto_route.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/membership_page.dart';

import '../pages/auth/register/register_page.dart';
import '../pages/auth/sign_in/sign_in_page.dart';
import '../pages/auth/splash/splash_screen_page.dart';
import '../pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart';
import '../pages/user_panel/contacts/contact_details/contact_details_page.dart';
import '../pages/user_panel/events/event_add_edit/event_add_edit_page.dart';
import '../pages/user_panel/events/event_details/event_details_page.dart';
import '../pages/user_panel/events/guests_selection/guests_selection_page.dart';
import '../pages/user_panel/home/home_page.dart';
import '../pages/user_panel/settings/change_email/change_email_page.dart';
import '../pages/user_panel/settings/change_password/change_password_page.dart';
import '../pages/user_panel/settings/country_code/country_code_page.dart';
import '../pages/user_panel/settings/events_settings/events_settings_page.dart';
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
    MaterialRoute(
        page: ContactAddEditPage,
        name: 'ContactAddEditMaterialRoute',
        fullscreenDialog: true),
    CupertinoRoute(page: UserProfilePage),
    CupertinoRoute(page: ChangeEmailPage),
    CupertinoRoute(page: ChangePasswordPage),
    CupertinoRoute(page: ImportContactsMenuPage),
    CupertinoRoute(page: TagsSettingsPage),
    CupertinoRoute(page: ImportedContactsPage),
    CupertinoRoute(page: ImportContactsPage),
    CupertinoRoute(page: CountryCodePage),
    CupertinoRoute(page: EventsSettingsPage),
    CupertinoRoute(page: EventDetailsPage),
    CupertinoRoute(page: GuestsSelectionPage),
    CupertinoRoute(page: EventAddEditPage),
    MaterialRoute(
      page: MembershipPage,
      fullscreenDialog: true,
    )
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
