import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../core/contacts_search_field/contacts_search_field.dart';
import '../../../../../core/dialogs.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactsAppBar({
    Key? key,
    required this.isSearchBarShowing,
    required bool isFiltered,
  })  : _isFiltered = isFiltered,
        super(key: key);

  final bool isSearchBarShowing;
  final bool _isFiltered;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isSearchBarShowing ? false : null,
      backgroundColor:
          isSearchBarShowing ? Theme.of(context).scaffoldBackgroundColor : null,
      title: isSearchBarShowing
          ? ContactsSearchField(
              autofocus: true,
              onChanged: (value) => context
                  .read(contactsNotifierProvider)
                  .search(searchText: value),
            )
          : Text(AppLocalizations.of(context)!.prospects),
      actions: isSearchBarShowing
          ? [
              TextButton(
                onPressed: () =>
                    context.read(contactsNotifierProvider).cancelSearch(),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              const SizedBox(width: 8.0),
            ]
          : [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  context.read(contactsNotifierProvider).showSearchBar();
                },
              ),
              Ink(
                width: 43.0,
                height: 43.0,
                decoration: ShapeDecoration(
                  color: _isFiltered
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  color: _isFiltered
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  onPressed: () {
                    showFiltersDialog(context);
                  },
                ),
              ),
              const SizedBox(width: 8.0),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
