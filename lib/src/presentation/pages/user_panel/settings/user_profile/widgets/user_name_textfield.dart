import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../logic/user_profile_provider.dart';

class UserNameTextField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String userName =
        context.read(userInfoNotifierProvider).user?.name ?? '';
    final bool showErrorMessages =
        watch(userProfileProvider).showInputErrorMessage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        initialValue: userName,
        textCapitalization: TextCapitalization.words,
        autovalidateMode: showErrorMessages
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: (value) {
          final bool isValid =
              context.read(userProfileProvider).validateFieldIsNotEmpty(value!);
          return isValid
              ? null
              : AppLocalizations.of(context).nameMustNotBeEmpty;
        },
        onChanged: (value) {
          context.read(userProfileProvider.notifier).nameChanged(value);
        },
      ),
    );
  }
}
