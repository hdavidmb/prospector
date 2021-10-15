import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../routes/app_router.gr.dart';

class SettingsMenuItems extends StatelessWidget {
  final Widget divider;
  SettingsMenuItems({
    Key? key,
    required this.divider,
  }) : super(key: key);

  final List<Map<String, dynamic>> items = [
    // {'title': AppLocalizations.of(context)!.membership}, //TODO implement
    {
      'title': AppLocalizations.current.importContacts,
      'route': const ImportContactsMenuRoute(),
    },
    // {'title': AppLocalizations.of(context)!.events}, //TODO implement
    {
      'title': AppLocalizations.current.tags,
      'route': const TagsSettingsRoute(),
    },
    {
      'title': AppLocalizations.current.countryCode,
      'route': const CountryCodeRoute(),
    }, //TODO implement
  ];

  @override
  Widget build(BuildContext context) {
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
