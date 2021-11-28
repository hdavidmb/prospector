import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../features/app_default_data/application/app_default_data_notifier.dart';
import '../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../logic/statistics_page_providers.dart';

class EffectivenessStatusDropdown extends ConsumerWidget {
  const EffectivenessStatusDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String selectedStatus =
        watch(effectivenessSelectedStatusProvider).state;
    final AppDefaultDataNotifier defaultData = watch(appDefaultDataProvider);

    return DropdownButtonFormField<String>(
      value: selectedStatus,
      items: [
        DropdownMenuItem(
            value: defaultData.notContactedID,
            child: Text(AppLocalizations.of(context).notContactedP)),
        DropdownMenuItem(
            value: defaultData.invitedID,
            child: Text(AppLocalizations.of(context).invitedP)),
        DropdownMenuItem(
            value: defaultData.followUpID,
            child: Text(AppLocalizations.of(context).followUp)),
      ],
      onChanged: (value) {
        if (value != null) {
          context.read(effectivenessSelectedStatusProvider).state = value;
        }
      },
    );
  }
}
