import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/tags_selection_wrap/tags_selection_wrap.dart';

class TagsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.tags)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 0.0),
        child: Align(
          child: TagsSelectionWrap(
            onTagsListChanged: (_) {},
            isEditing: true,
          ),
        ),
      ),
    );
  }
}
