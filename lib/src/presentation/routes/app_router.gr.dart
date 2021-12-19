// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;

import '../../features/contacts/domain/entity/contact_entity.dart' as _i22;
import '../../features/events/domain/entites/event_entity.dart' as _i23;
import '../pages/auth/register/register_page.dart' as _i4;
import '../pages/auth/sign_in/sign_in_page.dart' as _i3;
import '../pages/auth/splash/splash_screen_page.dart' as _i1;
import '../pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart'
    as _i6;
import '../pages/user_panel/contacts/contact_details/contact_details_page.dart'
    as _i5;
import '../pages/user_panel/events/event_add_edit/event_add_edit_page.dart'
    as _i18;
import '../pages/user_panel/events/event_details/event_details_page.dart'
    as _i16;
import '../pages/user_panel/events/guests_selection/guests_selection_page.dart'
    as _i17;
import '../pages/user_panel/home/home_page.dart' as _i2;
import '../pages/user_panel/membership/membership_page.dart' as _i19;
import '../pages/user_panel/settings/change_email/change_email_page.dart'
    as _i8;
import '../pages/user_panel/settings/change_password/change_password_page.dart'
    as _i9;
import '../pages/user_panel/settings/country_code/country_code_page.dart'
    as _i14;
import '../pages/user_panel/settings/events_settings/events_settings_page.dart'
    as _i15;
import '../pages/user_panel/settings/import_contacts/import_contacts/import_contacts_page.dart'
    as _i13;
import '../pages/user_panel/settings/import_contacts/import_contacts_menu/import_contacts_menu_page.dart'
    as _i10;
import '../pages/user_panel/settings/import_contacts/imported_contacts/imported_contacts_page.dart'
    as _i12;
import '../pages/user_panel/settings/tags_settings/tags_settings_page.dart'
    as _i11;
import '../pages/user_panel/settings/user_profile/user_profile_page.dart'
    as _i7;

class AppRouter extends _i20.RootStackRouter {
  AppRouter([_i21.GlobalKey<_i21.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeRoute.name: (routeData) {
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.HomePage(),
          transitionsBuilder: _i20.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    SignInRoute.name: (routeData) {
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.SignInPage(),
          transitionsBuilder: _i20.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    RegisterRoute.name: (routeData) {
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.RegisterPage(),
          transitionsBuilder: _i20.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ContactDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ContactDetailsRouteArgs>();
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData,
          child:
              _i5.ContactDetailsPage(key: args.key, contactID: args.contactID));
    },
    ContactAddEditRoute.name: (routeData) {
      final args = routeData.argsAs<ContactAddEditRouteArgs>(
          orElse: () => const ContactAddEditRouteArgs());
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i6.ContactAddEditPage(
              key: args.key, editingContact: args.editingContact));
    },
    ContactAddEditMaterialRoute.name: (routeData) {
      final args = routeData.argsAs<ContactAddEditMaterialRouteArgs>(
          orElse: () => const ContactAddEditMaterialRouteArgs());
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.ContactAddEditPage(
              key: args.key, editingContact: args.editingContact),
          fullscreenDialog: true);
    },
    UserProfileRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i7.UserProfilePage());
    },
    ChangeEmailRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i8.ChangeEmailPage());
    },
    ChangePasswordRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i9.ChangePasswordPage());
    },
    ImportContactsMenuRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i10.ImportContactsMenuPage());
    },
    TagsSettingsRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i11.TagsSettingsPage());
    },
    ImportedContactsRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i12.ImportedContactsPage());
    },
    ImportContactsRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i13.ImportContactsPage());
    },
    CountryCodeRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i14.CountryCodePage());
    },
    EventsSettingsRoute.name: (routeData) {
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i15.EventsSettingsPage());
    },
    EventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailsRouteArgs>();
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i16.EventDetailsPage(key: args.key, eventID: args.eventID));
    },
    GuestsSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<GuestsSelectionRouteArgs>(
          orElse: () => const GuestsSelectionRouteArgs());
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i17.GuestsSelectionPage(
              key: args.key, initialGuests: args.initialGuests));
    },
    EventAddEditRoute.name: (routeData) {
      final args = routeData.argsAs<EventAddEditRouteArgs>(
          orElse: () => const EventAddEditRouteArgs());
      return _i20.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i18.EventAddEditPage(
              key: args.key, editingEvent: args.editingEvent));
    },
    MembershipRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i19.MembershipPage(),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i20.RouteConfig> get routes => [
        _i20.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i20.RouteConfig(HomeRoute.name, path: '/home'),
        _i20.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i20.RouteConfig(RegisterRoute.name, path: '/register'),
        _i20.RouteConfig(ContactDetailsRoute.name,
            path: '/contact-details-page'),
        _i20.RouteConfig(ContactAddEditRoute.name,
            path: '/contact-add-edit-page'),
        _i20.RouteConfig(ContactAddEditMaterialRoute.name,
            path: '/contact-add-edit-page'),
        _i20.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i20.RouteConfig(ChangeEmailRoute.name, path: '/change-email-page'),
        _i20.RouteConfig(ChangePasswordRoute.name,
            path: '/change-password-page'),
        _i20.RouteConfig(ImportContactsMenuRoute.name,
            path: '/import-contacts-menu-page'),
        _i20.RouteConfig(TagsSettingsRoute.name, path: '/tags-settings-page'),
        _i20.RouteConfig(ImportedContactsRoute.name,
            path: '/imported-contacts-page'),
        _i20.RouteConfig(ImportContactsRoute.name,
            path: '/import-contacts-page'),
        _i20.RouteConfig(CountryCodeRoute.name, path: '/country-code-page'),
        _i20.RouteConfig(EventsSettingsRoute.name,
            path: '/events-settings-page'),
        _i20.RouteConfig(EventDetailsRoute.name, path: '/event-details-page'),
        _i20.RouteConfig(GuestsSelectionRoute.name,
            path: '/guests-selection-page'),
        _i20.RouteConfig(EventAddEditRoute.name, path: '/event-add-edit-page'),
        _i20.RouteConfig(MembershipRoute.name, path: '/membership-page')
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i20.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.HomePage]
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.SignInPage]
class SignInRoute extends _i20.PageRouteInfo<void> {
  const SignInRoute() : super(name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for [_i4.RegisterPage]
class RegisterRoute extends _i20.PageRouteInfo<void> {
  const RegisterRoute() : super(name, path: '/register');

  static const String name = 'RegisterRoute';
}

/// generated route for [_i5.ContactDetailsPage]
class ContactDetailsRoute extends _i20.PageRouteInfo<ContactDetailsRouteArgs> {
  ContactDetailsRoute({_i21.Key? key, required String? contactID})
      : super(name,
            path: '/contact-details-page',
            args: ContactDetailsRouteArgs(key: key, contactID: contactID));

  static const String name = 'ContactDetailsRoute';
}

class ContactDetailsRouteArgs {
  const ContactDetailsRouteArgs({this.key, required this.contactID});

  final _i21.Key? key;

  final String? contactID;

  @override
  String toString() {
    return 'ContactDetailsRouteArgs{key: $key, contactID: $contactID}';
  }
}

/// generated route for [_i6.ContactAddEditPage]
class ContactAddEditRoute extends _i20.PageRouteInfo<ContactAddEditRouteArgs> {
  ContactAddEditRoute({_i21.Key? key, _i22.Contact? editingContact})
      : super(name,
            path: '/contact-add-edit-page',
            args: ContactAddEditRouteArgs(
                key: key, editingContact: editingContact));

  static const String name = 'ContactAddEditRoute';
}

class ContactAddEditRouteArgs {
  const ContactAddEditRouteArgs({this.key, this.editingContact});

  final _i21.Key? key;

  final _i22.Contact? editingContact;

  @override
  String toString() {
    return 'ContactAddEditRouteArgs{key: $key, editingContact: $editingContact}';
  }
}

/// generated route for [_i6.ContactAddEditPage]
class ContactAddEditMaterialRoute
    extends _i20.PageRouteInfo<ContactAddEditMaterialRouteArgs> {
  ContactAddEditMaterialRoute({_i21.Key? key, _i22.Contact? editingContact})
      : super(name,
            path: '/contact-add-edit-page',
            args: ContactAddEditMaterialRouteArgs(
                key: key, editingContact: editingContact));

  static const String name = 'ContactAddEditMaterialRoute';
}

class ContactAddEditMaterialRouteArgs {
  const ContactAddEditMaterialRouteArgs({this.key, this.editingContact});

  final _i21.Key? key;

  final _i22.Contact? editingContact;

  @override
  String toString() {
    return 'ContactAddEditMaterialRouteArgs{key: $key, editingContact: $editingContact}';
  }
}

/// generated route for [_i7.UserProfilePage]
class UserProfileRoute extends _i20.PageRouteInfo<void> {
  const UserProfileRoute() : super(name, path: '/user-profile-page');

  static const String name = 'UserProfileRoute';
}

/// generated route for [_i8.ChangeEmailPage]
class ChangeEmailRoute extends _i20.PageRouteInfo<void> {
  const ChangeEmailRoute() : super(name, path: '/change-email-page');

  static const String name = 'ChangeEmailRoute';
}

/// generated route for [_i9.ChangePasswordPage]
class ChangePasswordRoute extends _i20.PageRouteInfo<void> {
  const ChangePasswordRoute() : super(name, path: '/change-password-page');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for [_i10.ImportContactsMenuPage]
class ImportContactsMenuRoute extends _i20.PageRouteInfo<void> {
  const ImportContactsMenuRoute()
      : super(name, path: '/import-contacts-menu-page');

  static const String name = 'ImportContactsMenuRoute';
}

/// generated route for [_i11.TagsSettingsPage]
class TagsSettingsRoute extends _i20.PageRouteInfo<void> {
  const TagsSettingsRoute() : super(name, path: '/tags-settings-page');

  static const String name = 'TagsSettingsRoute';
}

/// generated route for [_i12.ImportedContactsPage]
class ImportedContactsRoute extends _i20.PageRouteInfo<void> {
  const ImportedContactsRoute() : super(name, path: '/imported-contacts-page');

  static const String name = 'ImportedContactsRoute';
}

/// generated route for [_i13.ImportContactsPage]
class ImportContactsRoute extends _i20.PageRouteInfo<void> {
  const ImportContactsRoute() : super(name, path: '/import-contacts-page');

  static const String name = 'ImportContactsRoute';
}

/// generated route for [_i14.CountryCodePage]
class CountryCodeRoute extends _i20.PageRouteInfo<void> {
  const CountryCodeRoute() : super(name, path: '/country-code-page');

  static const String name = 'CountryCodeRoute';
}

/// generated route for [_i15.EventsSettingsPage]
class EventsSettingsRoute extends _i20.PageRouteInfo<void> {
  const EventsSettingsRoute() : super(name, path: '/events-settings-page');

  static const String name = 'EventsSettingsRoute';
}

/// generated route for [_i16.EventDetailsPage]
class EventDetailsRoute extends _i20.PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({_i21.Key? key, required String eventID})
      : super(name,
            path: '/event-details-page',
            args: EventDetailsRouteArgs(key: key, eventID: eventID));

  static const String name = 'EventDetailsRoute';
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({this.key, required this.eventID});

  final _i21.Key? key;

  final String eventID;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{key: $key, eventID: $eventID}';
  }
}

/// generated route for [_i17.GuestsSelectionPage]
class GuestsSelectionRoute
    extends _i20.PageRouteInfo<GuestsSelectionRouteArgs> {
  GuestsSelectionRoute({_i21.Key? key, List<String>? initialGuests})
      : super(name,
            path: '/guests-selection-page',
            args: GuestsSelectionRouteArgs(
                key: key, initialGuests: initialGuests));

  static const String name = 'GuestsSelectionRoute';
}

class GuestsSelectionRouteArgs {
  const GuestsSelectionRouteArgs({this.key, this.initialGuests});

  final _i21.Key? key;

  final List<String>? initialGuests;

  @override
  String toString() {
    return 'GuestsSelectionRouteArgs{key: $key, initialGuests: $initialGuests}';
  }
}

/// generated route for [_i18.EventAddEditPage]
class EventAddEditRoute extends _i20.PageRouteInfo<EventAddEditRouteArgs> {
  EventAddEditRoute({_i21.Key? key, _i23.Event? editingEvent})
      : super(name,
            path: '/event-add-edit-page',
            args: EventAddEditRouteArgs(key: key, editingEvent: editingEvent));

  static const String name = 'EventAddEditRoute';
}

class EventAddEditRouteArgs {
  const EventAddEditRouteArgs({this.key, this.editingEvent});

  final _i21.Key? key;

  final _i23.Event? editingEvent;

  @override
  String toString() {
    return 'EventAddEditRouteArgs{key: $key, editingEvent: $editingEvent}';
  }
}

/// generated route for [_i19.MembershipPage]
class MembershipRoute extends _i20.PageRouteInfo<void> {
  const MembershipRoute() : super(name, path: '/membership-page');

  static const String name = 'MembershipRoute';
}
