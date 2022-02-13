import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../routes/app_router.gr.dart';
import '../../change_email/logic/change_email_form_provider.dart';
import '../../change_password/logic/change_password_form_provider.dart';

class UserAuthProviderItems extends ConsumerWidget {
  final Widget divider = const Divider(height: 0.0);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String userAuthProvider =
        watch(userInfoNotifierProvider).getUserProvider();
    final bool isPassword = userAuthProvider == 'password';

    final List<Widget> items = isPassword
        ? <Widget>[
            divider,
            ListTile(
              onTap: () {
                context.read(changeEmailFormProvider.notifier).reset();
                AutoRouter.of(context).push(const ChangeEmailRoute());
              },
              title: Text(AppLocalizations.of(context).changeEmail),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    watch(userInfoNotifierProvider).user?.email ?? '',
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
            divider,
            ListTile(
              onTap: () {
                context.read(changePasswordFormProvider.notifier).reset();
                AutoRouter.of(context).push(const ChangePasswordRoute());
              },
              title: Text(AppLocalizations.of(context).changePassword),
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
                  Text(AppLocalizations.of(context).loggedInWith),
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
