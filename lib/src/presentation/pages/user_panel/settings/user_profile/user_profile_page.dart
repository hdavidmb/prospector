import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_auth_provider_items.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_avatar_edit.dart';

class UserProfilePage extends ConsumerWidget {
  final Widget divider = const Divider(height: 0.0);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final UserEntity user = watch(userInfoNotifierProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        actions: [
          TextButton(
            onPressed: () {
              //TODO save and pop
            },
            child: Text(AppLocalizations.of(context)!.save,
                style: Theme.of(context).textTheme.button),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 15.0),
          UserAvatarEdit(),
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              initialValue: user.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                //TODO user riverpod provider
              },
            ),
          ),
          const SizedBox(height: 15.0),
          UserAuthProviderItems(),
          const SizedBox(height: 15.0),
          divider,
          ListTile(
            onTap: () {
              //TODO user riverpod provider
            },
            title: Text(
              AppLocalizations.of(context)!.logOut,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          divider,
          ListTile(
            onTap: () {
              //TODO user riverpod provider
            },
            title: Text(
              AppLocalizations.of(context)!.deleteAccount,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          divider,
        ],
      ),
    );
  }
}
