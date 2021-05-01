import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_provider.dart';

import 'package:prospector/src/presentation/pages/user_panel/settings/widgets/user_avatar.dart';

class UserAvatarEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(onTap: () {
          //TODO pick image
          context.read(userProfileProvider).getAvatarImage(context);
        }, child: Consumer(builder: (context, watch, child) {
          //TODO get pickedImage from provider
          final File? pickedImageFile = watch(userProfileProvider).pickedImage;
          return Hero(
            tag: 'user_avatar',
            child: UserAvatar(
                size: 150.0, pickedImage: pickedImageFile,), //TODO use file image to show image picked
          );
        })),
        TextButton(
          style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {
            //TODO pick image
          context.read(userProfileProvider).getAvatarImage(context);
          },
          child: Text(AppLocalizations.of(context)!.editImage),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
