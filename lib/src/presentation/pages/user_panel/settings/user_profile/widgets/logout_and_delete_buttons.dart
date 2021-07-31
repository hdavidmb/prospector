import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/user_profile_provider.dart';


class LogoutAndDeleteButtons extends ConsumerWidget {
  final Widget divider = const Divider(height: 0.0);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(children: [
      divider,
          ListTile(
            onTap: () async {
              await context.read(userProfileProvider.notifier).signOut();
            },
            title: Text(
              AppLocalizations.of(context)!.logOut,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          divider,
          ListTile(
            onTap: () async {
              await context.read(userProfileProvider.notifier).deleteAccountButtonPressed(context: context);
            },
            title: Text(
              AppLocalizations.of(context)!.deleteAccount,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          divider,
    ]);
  }
}