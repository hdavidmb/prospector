import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/analytics/firebase_analytics_providers.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../routes/app_router.gr.dart';
import 'widgets/settings_admob_banner.dart';
import 'widgets/settings_menu_items.dart';
import 'widgets/theme_switch.dart';
import 'widgets/user_profile_list_tile.dart';

class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: 0.0,
      indent: 10.0,
    );
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scrollbar(
            child: Consumer(
              builder: (context, watch, child) {
                final bool isPremium =
                    watch(userInfoNotifierProvider).isPremiumUser;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    UserProfileListTile(),
                    divider,
                    ListTile(
                      title: Text(AppLocalizations.of(context).membership),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        AutoRouter.of(context).push(const MembershipRoute());

                        context
                            .read(firebaseAnalyticsServiceProvider)
                            .logPromptMembershipPage(
                                fromPage: 'premium_dialog'); //TODO: test
                      },
                    ),
                    divider,
                    const SizedBox(height: 30.0),
                    divider,
                    SettingsMenuItems(divider: divider),
                    const SizedBox(height: 30.0),
                    divider,
                    ThemeSwitch(),
                    divider,
                    if (!isPremium) const SizedBox(height: 100.0)
                  ],
                );
              },
            ),
          ),
          const Positioned(
            bottom: 10.0,
            child: SafeArea(child: SettingsAdmobBanner()),
          ) //TODO: remove if blocking content
        ],
      ),
    );
  }
}
