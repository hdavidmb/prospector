import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile_page.dart';
import 'package:prospector/src/presentation/theme/theme_constants.dart';

class UserProfileListTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final UserEntity user = watch(userInfoNotifierProvider).user;
    final String premiumSubID = context
        .read(appDefaultDataProvider).premiumSubID;
    final bool isPremium = user.subscription == premiumSubID;

    const double profileImageSize = 80.0;
    final Locale myLocale = Localizations.localeOf(context);
    final dateFormat = DateFormat.yMd(myLocale.languageCode);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => UserProfilePage()));
        //context.read(signOut).call; //TODO navigate to user profile
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                radius: 45.0,
                backgroundColor: isPremium
                    ? kPremiumColor
                    : Colors.transparent,
                child: CircleAvatar(
                  radius: 42.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Container(
                      color: Colors.white60,
                      child: (user.photoURL == null ||
                              user.photoURL!.isEmpty)
                          ? const Image(
                              image: AssetImage(
                                  'assets/images/defaultContactImage.jpg'),
                              height: profileImageSize,
                              fit: BoxFit.cover,
                            )
                          : FadeInImage(
                            fit: BoxFit.cover,
                            height: profileImageSize,
                            width: profileImageSize,
                              placeholder: const AssetImage(
                                  'assets/images/loading.gif'),
                              image: NetworkImage(
                                  user.photoURL!)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name.isNotEmpty ? user.name : AppLocalizations.of(context)!.profile, style: Theme.of(context).textTheme.headline6),
                  if (user.email != null)
                    Text(user.email!,
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                  if (isPremium) ...[
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.premiumCap,
                            style: const TextStyle(
                                color: kPremiumColor,
                                fontWeight: FontWeight.bold)),
                        Text(
                            '${AppLocalizations.of(context)!.until} ${dateFormat.format(user.expiryDate)}',
                            style: Theme.of(context).textTheme.caption)
                      ],
                    )
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
