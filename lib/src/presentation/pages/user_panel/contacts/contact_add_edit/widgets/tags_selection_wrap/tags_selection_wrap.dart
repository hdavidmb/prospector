import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../../../../../../generated/l10n.dart';
import '../../../../../../../features/tags/application/tags_provider.dart';
import '../../../../../../../features/tags/domain/entity/tag_entity.dart';
import '../../../../../../core/dialogs.dart';
import 'widgets/tag_chip.dart';

class TagsSelectionWrap extends ConsumerWidget {
  final List<String> selectedTags;
  final bool isEditing;
  final bool canAdd;
  final void Function(List<String>) onTagsListChanged;
  const TagsSelectionWrap({
    this.selectedTags = const <String>[],
    this.isEditing = false,
    this.canAdd = true,
    required this.onTagsListChanged,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Widget> wrapChildren = [];
    final List<Tag> userTags = watch(tagsNotifierProvider).tags;
    final List<Widget> tagsChips = userTags
        .map(
          (tag) => TagChip(
            tag: tag,
            isEditing: isEditing,
            selected: selectedTags.contains(tag.id),
            onSelected: (selected) {
              if (selected) {
                selectedTags.add(tag.id);
              } else {
                selectedTags.remove(tag.id);
              }
              onTagsListChanged(selectedTags);
            },
          ),
        )
        .toList();
    final Widget addButton = userTags.isEmpty
        ? TextButton.icon(
            icon: const Icon(Icons.add_circle),
            label: Text(AppLocalizations.of(context).addTag),
            style: TextButton.styleFrom(
                primary: Theme.of(context).textTheme.button!.color),
            onPressed: () => _addTag(context: context),
          )
        : IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => _addTag(context: context),
          );
    wrapChildren.addAll(tagsChips);
    if (canAdd) wrapChildren.add(addButton);
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        runSpacing: -5.0,
        children: wrapChildren);
  }

  Future<void> _addTag({required BuildContext context}) async {
    // Ask for new tag name on dialog
    final newTagNameOption = await showTextFieldDialog(
      context: context,
      title: Text(AppLocalizations.current.addANewTag),
      hintText: AppLocalizations.current.tagName,
    );
    newTagNameOption.fold(
      () => null,
      (newTagName) {
        // Arrange tag entity with generated ID
        final id = randomAlphaNumeric(20);
        final newTag = Tag(id: id, name: newTagName, created: DateTime.now());

        // Create Tag on databases
        context.read(tagsNotifierProvider).createTag(newTag);
      },
    );
  }
}
