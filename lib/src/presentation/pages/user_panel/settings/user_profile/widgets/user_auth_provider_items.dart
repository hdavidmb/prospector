import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class UserAuthProviderItems extends ConsumerWidget {
  final Widget divider = const Divider(height: 0.0);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String userAuthProvider =
        watch(userInfoNotifierProvider).getUserProvider();
    final bool isPassword = userAuthProvider == 'password';

    final List<Widget> items = isPassword
        ? [
            divider,
            ListTile(
              onTap: () {
                //TODO user riverpod provider
              },
              title: Text(AppLocalizations.of(context)!.changeEmail),
              trailing: const Icon(Icons.chevron_right),
            ),
            divider,
            ListTile(
              onTap: () {
                //TODO user riverpod provider
              },
              title: Text(AppLocalizations.of(context)!.changePassword),
              trailing: const Icon(Icons.chevron_right),
            ),
            divider
          ]
        : [
            divider,
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.loggedInWith),
                  Text(
                    userAuthProvider == 'facebook.com'
                        ? 'Facebook'
                        : userAuthProvider == 'google.com'
                            ? 'Google'
                            : 'Apple',
                  )
                ],
              ),
            ),
            divider,
          ];
    return Column(children: items);
  }
}
