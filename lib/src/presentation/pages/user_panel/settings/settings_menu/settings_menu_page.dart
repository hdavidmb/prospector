import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/settings_menu/widgets/theme_switch.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/settings_menu/widgets/user_profile_list_tile.dart';

class SettingsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 0.0);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UserProfileListTile(),
          ),
          divider,
          ThemeSwitch(),
          divider,
        ],
      ),
    );
  }
}
