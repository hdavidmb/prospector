import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/widgets/imported_contact_tile.dart';

class ImportContactsListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<ImportedContact> deviceContacts =
        watch(importContactsProvider).deviceContacts;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: deviceContacts.length,
      itemBuilder: (context, index) => ImportedContactTile(
        contact: deviceContacts[index],
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        indent: 10.0,
      ),
    );
  }
}
