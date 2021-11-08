import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../generated/l10n.dart';
import '../../../../../../core/widgets/contacts_search_field/contacts_search_field.dart';
import '../logic/impor_contacts_page_providers.dart';

class ImportContactsSearchBar extends StatefulWidget {
  @override
  _ImportContactsSearchBarState createState() =>
      _ImportContactsSearchBarState();
}

class _ImportContactsSearchBarState extends State<ImportContactsSearchBar> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ContactsSearchField(
                  controller: _controller,
                  onChanged: context
                      .read(importContactsPageProvider)
                      .searchTextChanged,
                ),
              ),
              TextButton(
                onPressed: () {
                  _controller.clear();
                  context
                      .read(importContactsPageProvider)
                      .searchTextChanged('');
                  FocusScope.of(context).unfocus();
                },
                child: Text(AppLocalizations.of(context).cancel),
              )
            ],
          ),
        ),
        const Divider(height: 0.0)
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
