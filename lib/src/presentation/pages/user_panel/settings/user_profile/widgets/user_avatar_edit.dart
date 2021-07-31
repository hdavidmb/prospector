import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/user_avatar.dart';
import '../logic/user_profile_provider.dart';

class UserAvatarEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(onTap: () {
          context.read(userProfileProvider).getAvatarImage(context);
        }, child: Consumer(builder: (context, watch, child) {
          final File? pickedImageFile = watch(userProfileProvider).pickedImage;
          return Hero(
            tag: 'user_avatar',
            child: UserAvatar(
                size: 150.0, pickedImage: pickedImageFile,), 
          );
        })),
        TextButton(
          style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {
          context.read(userProfileProvider).getAvatarImage(context);
          },
          child: Text(AppLocalizations.of(context)!.editImage),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
