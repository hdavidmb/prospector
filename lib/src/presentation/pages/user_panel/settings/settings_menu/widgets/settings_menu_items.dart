import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/imported_contacts/imported_contacts.dart';

class SettingsMenuItems extends StatelessWidget {
  final Widget divider;
  const SettingsMenuItems({
    Key? key,
    required this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      // {'title': AppLocalizations.of(context)!.membership}, //TODO implement
      {
        'title': AppLocalizations.of(context)!.importContacts,
        'page': ImportedContactsPage()
      },
      // {'title': AppLocalizations.of(context)!.events}, //TODO implement
      // {'title': AppLocalizations.of(context)!.tags}, //TODO implement
      // {'title': AppLocalizations.of(context)!.whatsapp}, //TODO implement
    ];

    final List<Widget> tiles = [];

    for (final Map<String, dynamic> item in items) {
      tiles.addAll(
        [
          ListTile(
            title: Text(item['title'] as String),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => item['page'] as Widget));
            },
          ),
          divider,
        ],
      );
    }
    return Column(children: tiles);
  }
}
