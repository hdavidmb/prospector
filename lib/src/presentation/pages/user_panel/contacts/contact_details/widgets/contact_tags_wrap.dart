import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/tags/application/tags_provider.dart';
import '../../../../../../features/tags/domain/entity/tag_entity.dart';

class ContactTagsWrap extends ConsumerWidget {
  final List<String> tags;
  const ContactTagsWrap({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Widget> tagsList = [];
    final List<Tag> userTags = watch(tagsNotifierProvider).tags;
    const double fontSize = 14.0;
    const double verticalPadding = 6.0;
    for (final String tag in tags) {
      final List<String> userTagsIDs = userTags.map((userTag) => userTag.id).toList();
      if (!userTagsIDs.contains(tag)) break;
      final tagName = userTags.firstWhere((userTag) => userTag.id == tag).name;
      tagsList.add(
        Container(
          height: fontSize + verticalPadding,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                  Radius.circular((fontSize + verticalPadding) / 2)),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tagName,
                style: const TextStyle(color: Colors.white, fontSize: fontSize),
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.center,
          children: tagsList),
    );
  }
}
