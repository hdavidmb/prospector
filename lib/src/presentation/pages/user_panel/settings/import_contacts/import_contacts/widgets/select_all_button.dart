import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/logic/impor_contacts_page_providers.dart';

class SelectAllButton extends StatelessWidget {
  final bool allSelected;
  const SelectAllButton({
    Key? key,
    required this.allSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(children: [
      const Divider(height: 0.0),
      Container(
        color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
        child: Center(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onPressed:
                context.read(importContactsPageProvider).selectAllButtonPressed,
            child: Text(allSelected
                ? AppLocalizations.of(context)!.unselectAll
                : AppLocalizations.of(context)!.selectAll),
          ),
        ),
      ),
    ]);
  }
}
