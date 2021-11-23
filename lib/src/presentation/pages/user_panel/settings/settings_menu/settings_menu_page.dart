import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                UserProfileListTile(),
                divider,
                ListTile(
                  title: Text(AppLocalizations.of(context).membership),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      AutoRouter.of(context).push(const MembershipRoute()),
                ),
                divider,
                const SizedBox(height: 30.0),
                divider,
                SettingsMenuItems(divider: divider),
                const SizedBox(height: 30.0),
                divider,
                ThemeSwitch(),
                divider,
              ],
            ),
          ),
          const SettingsAdmobBanner() //TODO: remove if blocking content
        ],
      ),
    );
  }
}
