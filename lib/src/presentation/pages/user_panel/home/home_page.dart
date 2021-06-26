import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/application/auth_providers.dart';
import '../../../../features/auth/application/auth_state.dart';
import '../../../../features/user/application/user_info_providers.dart';
import '../../../core/fade_page_route.dart';
import '../../auth/register/logic/register_form_provider.dart';
import '../../auth/sign_in/logic/sign_in_form_provider.dart';
import '../../auth/sign_in/sign_in_page.dart';
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
        'label': 'Statistics' //TODO localize
      },
      {
        'icon': const Icon(Icons.people),
        'page': ContactsListPage(),
        'label': 'Prospects' //TODO localize
      },
      {
        'icon': const Icon(Icons.person_add),
        'page': const ContactAddEditPage(),
        'label': 'New' //TODO localize
      },
      {
        'icon': const Icon(Icons.event),
        'page': Container(), //TODO implement statistics page
        'label': 'Events' //TODO localize
      },
      {
        'icon': const Icon(Icons.settings),
        'page': SettingsMenuPage(), //TODO implement statistics page
        'label': 'Settings' //TODO localize
      },
    ];
    // * This provider listener must always be at the top of the home widget tree
    return ProviderListener<AuthState>(
      provider: authStateNotifierProvider,
      onChange: (context, authState) {
        if (authState == const AuthState.unauthenticated()) {
          context.read(signInFormProvider.notifier).reset();
          context.read(registerFormProvider.notifier).reset();
          context.read(userInfoNotifierProvider).reset();
          Navigator.pushAndRemoveUntil(
              context,
              FadePageRoute().call(page: SignInPage()),
              (Route<dynamic> route) => false);
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
              onTap: (index) => indexProvider.state = index,
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
