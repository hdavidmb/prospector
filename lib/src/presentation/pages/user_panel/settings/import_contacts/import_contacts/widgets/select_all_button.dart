import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../generated/l10n.dart';
import '../logic/impor_contacts_page_providers.dart';

class SelectAllButton extends StatelessWidget {
  final bool allSelected;
  const SelectAllButton({
    Key? key,
    required this.allSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        onPressed:
            context.read(importContactsPageProvider).selectAllButtonPressed,
        child: Text(allSelected
            ? AppLocalizations.of(context).unselectAll
            : AppLocalizations.of(context).selectAll),
      ),
    );
  }
}
