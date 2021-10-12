import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';

class StatusDropdown extends ConsumerWidget {
  final String status;
  final String gender;
  final void Function(String) onStatusChanged;
  const StatusDropdown({
    Key? key,
    required this.status,
    required this.gender,
    required this.onStatusChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String notInterestedID =
        context.read(appDefaultDataProvider).notInterestedID;
    final String notContactedID =
        context.read(appDefaultDataProvider).notContactedID;
    final String invitedID = context.read(appDefaultDataProvider).invitedID;
    final String followUpID = context.read(appDefaultDataProvider).followUpID;
    final String clientID = context.read(appDefaultDataProvider).clientID;
    final String executiveID = context.read(appDefaultDataProvider).executiveID;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
          child: FaIcon(context
              .read(appDefaultDataProvider)
              .getStatusIcon(statusID: status)),
        ),
      ),
      value: status.isNotEmpty
          ? status
          : context.read(appDefaultDataProvider).notContactedID,
      items: [
        DropdownMenuItem<String>(
          value: notInterestedID,
          child:
              Text(getStatusText(context: context, statusID: notInterestedID)),
        ),
        DropdownMenuItem<String>(
          value: notContactedID,
          child:
              Text(getStatusText(context: context, statusID: notContactedID)),
        ),
        DropdownMenuItem<String>(
          value: invitedID,
          child: Text(getStatusText(context: context, statusID: invitedID)),
        ),
        DropdownMenuItem<String>(
          value: followUpID,
          child: Text(getStatusText(context: context, statusID: followUpID)),
        ),
        DropdownMenuItem<String>(
          value: clientID,
          child: Text(getStatusText(context: context, statusID: clientID)),
        ),
        DropdownMenuItem<String>(
          value: executiveID,
          child: Text(getStatusText(context: context, statusID: executiveID)),
        ),
      ],
      onChanged: (value) => onStatusChanged(value!),
    );
  }

  String getStatusText(
      {required BuildContext context, required String statusID}) {
    return context
        .read(appDefaultDataProvider)
        .getStatusText(statusID: statusID, gender: gender);
  }
}
