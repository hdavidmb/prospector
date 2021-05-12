import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/core/fade_page_route.dart';
import 'package:prospector/src/presentation/pages/auth/register/logic/register_form_provider.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_provider.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/contacts_list_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/settings_menu/settings_menu_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      child: const ContactAddEditPage(),
      // child: ContactAddEditPage(editingContact: Contact(id: 'id', name: 'name', status: 'u9uvk4CbYDoc2PQLdIv8', created: DateTime.now(), modified: DateTime.now()),),
      // child: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       final editingContact = Contact(id: 'id', name: 'name', status: 'u9uvk4CbYDoc2PQLdIv8', created: DateTime.now(), modified: DateTime.now());
      //       context.read(contactFormProvider.notifier).setEditingState(editingContact: editingContact);
      //       Navigator.push(context, CupertinoPageRoute(builder: (context) => ContactAddEditPage(editingContact: editingContact,)));
      //     },
      //     child: Text('Edit Contact'),
      //   ),
      // ),

      //SettingsMenuPage(),
      // child: Scaffold(
      //   appBar: AppBar(title: const Text('Home')),
      //   body: Center(
      //     child: Column(
      //       children: [
      //         Text(user.name),
      //         Text(user.email ?? ''),
      //         Text(user.subscription),
      //         Text(user.photoURL ?? ''),
      //         ElevatedButton(
      //             onPressed: context.read(signOut).call,
      //             child: const Text('Sign out')),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
