import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../routes/app_router.gr.dart';

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
        'route': const ImportContactsMenuRoute(),
      },
      // {'title': AppLocalizations.of(context)!.events}, //TODO implement
      {
        'title': AppLocalizations.of(context)!.tags,
        'route': const TagsSettingsRoute(),
      },
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
              AutoRouter.of(context).push(item['route'] as PageRouteInfo);
            },
          ),
          divider,
        ],
      );
    }
    return Column(children: tiles);
  }
}
