import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/user/application/user_info_providers.dart';
import '../../../../../features/user/domain/entity/user_entity.dart';
import '../../../../theme/theme_constants.dart';

class UserAvatar extends ConsumerWidget {
  final double size;
  final File? pickedImage;

  const UserAvatar({
    required this.size,
    this.pickedImage,
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final UserEntity? user = watch(userInfoNotifierProvider).user;
    final bool isPremium = watch(userInfoNotifierProvider).isPremiumUser;
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: isPremium ? kPremiumColor : Colors.transparent,
      child: CircleAvatar(
        radius: size / 2 - 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2 - 5),
          child: Container(
            color: Colors.white60,
            child: pickedImage == null
                ? (user == null ||
                        user.photoURL == null ||
                        user.photoURL!.isEmpty)
                    ? Image(
                        image: const AssetImage(
                            'assets/images/defaultContactImage.jpg'),
                        height: size - 10,
                        width: size - 10,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: size - 10,
                        width: size - 10,
                        imageUrl: user.photoURL!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                : Image(
                    image: FileImage(pickedImage!),
                    height: size - 10,
                    width: size - 10,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
