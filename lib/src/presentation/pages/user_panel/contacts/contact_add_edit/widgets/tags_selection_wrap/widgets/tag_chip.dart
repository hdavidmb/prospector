import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../features/tags/application/tags_provider.dart';
import '../../../../../../../../features/tags/domain/entity/tag_entity.dart';

class TagChip extends ConsumerWidget {
  final Tag tag;
  final bool isEditing;
  final bool selected;
  final void Function(bool)? onSelected;
  const TagChip({
    required this.tag,
    this.isEditing = false,
    this.selected = false,
    this.onSelected,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return !isEditing
        ? ChoiceChip(
            label: Text(
              tag.name,
              style: TextStyle(
                  color: selected
                      ? Theme.of(context).primaryTextTheme.button!.color
                      : Theme.of(context).textTheme.button!.color),
            ),
            selected: selected,
            selectedColor: Theme.of(context).primaryColor,
            onSelected: onSelected,
          )
        : Chip(
            label: Text(tag.name),
            deleteIcon: const Icon(
              Icons.cancel,
              size: 20.0,
            ),
            onDeleted: () {
              context.read(tagsNotifierProvider).deleteTag(tagID: tag.id);
            },
          );
  }
}
