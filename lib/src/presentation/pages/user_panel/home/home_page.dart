import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/routes/app_router.gr.dart';

import '../../../../features/auth/application/auth_providers.dart';
import '../../../../features/auth/application/auth_state.dart';
import '../../auth/register/logic/register_form_provider.dart';
import '../../auth/sign_in/logic/sign_in_form_provider.dart';
import '../contacts/contact_add_edit/contact_add_edit_page.dart';
import '../contacts/contacts_list/contacts_list_page.dart';
import '../settings/settings_menu/settings_menu_page.dart';
import 'logic/home_index_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        'icon': const Icon(Icons.insert_chart),
        'page': Container(), //TODO implement statistics page
        'label': AppLocalizations.of(context)!.statistics,
      },
      {
        'icon': const Icon(Icons.people),
        'page': ContactsListPage(),
        'label': AppLocalizations.of(context)!.prospects,
      },
      {
        'icon': const Icon(Icons.person_add),
        'page': const ContactAddEditPage(),
        'label': AppLocalizations.of(context)!.newString,
      },
      {
        'icon': const Icon(Icons.event),
        'page': Container(), //TODO implement events page
        'label': AppLocalizations.of(context)!.events,
      },
      {
        'icon': const Icon(Icons.settings),
        'page': SettingsMenuPage(),
        'label': AppLocalizations.of(context)!.settings,
      },
    ];
    // * This provider listener must always be at the top of the home widget tree
    return ProviderListener<AuthState>(
      provider: authStateNotifierProvider,
      onChange: (context, authState) {
        if (authState == const AuthState.unauthenticated()) {
          context.read(signInFormProvider.notifier).reset();
          context.read(registerFormProvider.notifier).reset();

          AutoRouter.of(context).replaceAll(const [SignInRoute()]);
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final indexProvider = watch(homeIndexProvider);
          final int currentIndex = indexProvider.state;
          return Scaffold(
            body: pages[currentIndex]['page'] as Widget,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) => context.read(homeIndexProvider).state = index,
              items: pages
                  .map(
                    (pageMap) => BottomNavigationBarItem(
                      icon: pageMap['icon'] as Icon,
                      label: pageMap['label'] as String,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
