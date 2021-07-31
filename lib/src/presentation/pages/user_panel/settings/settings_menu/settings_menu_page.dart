import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/settings_menu_items.dart';
import 'widgets/theme_switch.dart';
import 'widgets/user_profile_list_tile.dart';

class SettingsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 0.0, indent: 10.0,);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          UserProfileListTile(),
          divider,
          const SettingsMenuItems(divider: divider),
          ThemeSwitch(),
          divider,
        ],
      ),
    );
  }
}
