import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/settings_menu/widgets/user_profile_list_tile.dart';

class SettingsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 0.0);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            UserProfileListTile(),
            divider,
          ],
        ),
      ),
    );
  }
}
