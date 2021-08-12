import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../routes/app_router.gr.dart';
import 'logic/import_contacts_menu_provider.dart';

class ImportContactsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 0.0, indent: 8.0);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.importContacts),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.importContacts),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                AutoRouter.of(context).push(const ImportedContactsRoute()),
          ),
          divider,
          Consumer(
            builder: (context, watch, child) {
              final bool isPremiumUser =
                  watch(userInfoNotifierProvider).isPremiumUser;
              final bool syncContactsEnabled =
                  watch(imporContactsMenuProvider).syncContactsEnabled;
              return SwitchListTile.adaptive(
                title: Text(AppLocalizations.of(context)!.syncContacts),
                value: isPremiumUser && syncContactsEnabled,
                onChanged: (value) => context
                    .read(imporContactsMenuProvider)
                    .syncContactsSwitchTapped(context, value: value),
              );
            },
          ),
          divider,
        ],
      ),
    );
  }
}
