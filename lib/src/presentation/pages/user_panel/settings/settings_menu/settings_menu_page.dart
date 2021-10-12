import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import 'widgets/settings_admob_banner.dart';
import 'widgets/settings_menu_items.dart';
import 'widgets/theme_switch.dart';
import 'widgets/user_profile_list_tile.dart';

class SettingsMenuPage extends StatelessWidget {
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
                SettingsMenuItems(divider: divider),
                ThemeSwitch(),
                divider,
              ],
            ),
          ),
          const SettingsAdmobBanner()
        ],
      ),
    );
  }
}
