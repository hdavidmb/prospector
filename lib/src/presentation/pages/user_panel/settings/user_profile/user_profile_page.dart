import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/loading_page_cover.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_notifier.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/logout_and_delete_buttons.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_auth_provider_items.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_avatar_edit.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/user_name_textfield.dart';

class UserProfilePage extends ConsumerWidget {
  final Widget divider = const Divider(height: 0.0);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isSubmitting = watch(userProfileProvider).userProfileState ==
        const UserProfileState.submitting();
    return ProviderListener<UserProfileNotifier>(
      provider: userProfileProvider,
      onChange: (context, notifier) {
        notifier.userProfileState.maybeWhen(
          error: (failure) => showFailureSnackbar(context, failure),
          reloginError: (failure) => showFailureSnackbar(context, failure),
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
                onPressed: isSubmitting
                    ? null
                    : () async {
                        final success = await context
                            .read(userProfileProvider.notifier)
                            .saveButtonPressed();
                        if (success) Navigator.of(context).pop();
                      },
                child: Text(AppLocalizations.of(context)!.save,
                    style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
          body: Stack(
            children: [
              ListView(
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
              if (isSubmitting) LoadingPageCover(),
                // TODO test Container(
                //   color: Colors.grey.withOpacity(0.5),
                //   child: const Center(
                //     child: CircularProgressIndicator.adaptive(),
                //   ),
                // ),
            ],
          ),
        ),
      ),
    );
  }
}
