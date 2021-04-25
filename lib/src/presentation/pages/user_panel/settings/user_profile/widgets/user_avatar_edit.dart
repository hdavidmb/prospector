import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/pages/user_panel/settings/widgets/user_avatar.dart';

class UserAvatarEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            //TODO pick image
          },
          child: const Hero(
            tag: 'user_avatar',
            child: UserAvatar(size: 150.0),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {
            //TODO pick image
          },
          child: Text(AppLocalizations.of(context)!.editImage),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
