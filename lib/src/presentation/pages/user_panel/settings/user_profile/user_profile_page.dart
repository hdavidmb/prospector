import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/helpers/process_auth_failure.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/logout_and_delete_buttons.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_auth_provider_items.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_avatar_edit.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_name_textfield.dart';

class UserProfilePage extends StatelessWidget {
  final Widget divider = const Divider(height: 0.0);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<UserProfileState>(
      provider: userProfileProvider,
      onChange: (context, state) {
        state.maybeWhen(
          error: (failure) => showAuthFailureSnackbar(context, failure),
          reloginError: (failure) => showAuthFailureSnackbar(context, failure),
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.profile),
            actions: [
              TextButton(
                onPressed: () async {
                  final success = await context.read(userProfileProvider.notifier).saveButtonPressed();
                  if (success) Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.save,
                    style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 15.0),
              UserAvatarEdit(),
              const SizedBox(height: 15.0),
              UserNameTextField(),
              const SizedBox(height: 15.0),
              UserAuthProviderItems(),
              const SizedBox(height: 15.0),
              LogoutAndDeleteButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
