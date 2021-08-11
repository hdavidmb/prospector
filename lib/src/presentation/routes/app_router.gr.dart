// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i2;

import '../../features/contacts/domain/entity/contact_entity.dart' as _i10;
import '../pages/auth/register/register_page.dart' as _i6;
import '../pages/auth/sign_in/sign_in_page.dart' as _i5;
import '../pages/splash/splash_screen_page.dart' as _i3;
import '../pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart'
    as _i8;
import '../pages/user_panel/contacts/contact_details/contact_details_page.dart'
    as _i7;
import '../pages/user_panel/home/home_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashScreenPage();
        }),
    HomeRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomePage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    SignInRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.SignInPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    RegisterRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.RegisterPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    ContactDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ContactDetailsRouteArgs>();
          return _i7.ContactDetailsPage(
              key: args.key, contactID: args.contactID);
        }),
    ContactAddEditRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ContactAddEditRouteArgs>(
              orElse: () => const ContactAddEditRouteArgs());
          return _i8.ContactAddEditPage(
              key: args.key, editingContact: args.editingContact);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register'),
        _i1.RouteConfig(ContactDetailsRoute.name,
            path: '/contact-details-page'),
        _i1.RouteConfig(ContactAddEditRoute.name,
            path: '/contact-add-edit-page')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

class RegisterRoute extends _i1.PageRouteInfo {
  const RegisterRoute() : super(name, path: '/register');

  static const String name = 'RegisterRoute';
}

class ContactDetailsRoute extends _i1.PageRouteInfo<ContactDetailsRouteArgs> {
  ContactDetailsRoute({_i9.Key? key, required String? contactID})
      : super(name,
            path: '/contact-details-page',
            args: ContactDetailsRouteArgs(key: key, contactID: contactID));

  static const String name = 'ContactDetailsRoute';
}

class ContactDetailsRouteArgs {
  const ContactDetailsRouteArgs({this.key, required this.contactID});

  final _i9.Key? key;

  final String? contactID;
}

class ContactAddEditRoute extends _i1.PageRouteInfo<ContactAddEditRouteArgs> {
  ContactAddEditRoute({_i9.Key? key, _i10.Contact? editingContact})
      : super(name,
            path: '/contact-add-edit-page',
            args: ContactAddEditRouteArgs(
                key: key, editingContact: editingContact));

  static const String name = 'ContactAddEditRoute';
}

class ContactAddEditRouteArgs {
  const ContactAddEditRouteArgs({this.key, this.editingContact});

  final _i9.Key? key;

  final _i10.Contact? editingContact;
}
