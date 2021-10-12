import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../features/user/application/user_info_providers.dart';
import '../../../../core/dialogs.dart';
import 'logic/user_profile_notifier.dart';
import 'logic/user_profile_provider.dart';
import 'logic/user_profile_state.dart';
import 'widgets/loading_page_cover.dart';
import 'widgets/logout_and_delete_buttons.dart';
import 'widgets/user_auth_provider_items.dart';
import 'widgets/user_avatar_edit.dart';
import 'widgets/user_name_textfield.dart';

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
            title: Text(AppLocalizations.of(context).profile),
            actions: [
              TextButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        final success = await context
                            .read(userProfileProvider.notifier)
                            .saveButtonPressed();
                        if (success) {
                          Future.delayed(Duration.zero, () {
                            AutoRouter.of(context).pop();
                          });
                        }
                      },
                child: Text(AppLocalizations.of(context).save,
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
                  //TODO temporal delete
                  const SizedBox(height: 15.0),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.yellow, backgroundColor: Colors.blue),
                    onPressed: () {
                      final premiumSubID =
                          context.read(appDefaultDataProvider).premiumSubID;
                      final freeSubID =
                          context.read(appDefaultDataProvider).freeSubID;
                      final user = context.read(userInfoNotifierProvider).user;
                      final isPremiumUser =
                          context.read(userInfoNotifierProvider).isPremiumUser;
                      final newUserInfo = user?.copyWith(
                          subscription:
                              isPremiumUser ? freeSubID : premiumSubID);
                      if (newUserInfo != null) {
                        context
                            .read(userInfoNotifierProvider)
                            .updateUserInfo(newUserInfo);
                      }
                    },
                    child: const Text('Change subscription'),
                  )
                  //TODO temporal delete
                ],
              ),
              if (isSubmitting) LoadingPageCover(),
            ],
          ),
        ),
      ),
    );
  }
}
