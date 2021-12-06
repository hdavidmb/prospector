import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../generated/l10n.dart';

class GenderDropdown extends StatelessWidget {
  final String gender;
  final void Function(String) onGenderChanged;
  const GenderDropdown({
    Key? key,
    required this.gender,
    required this.onGenderChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 12.0, horizontal: gender == '' ? 10.0 : 17.0),
          child: FaIcon(gender == 'male'
              ? FontAwesomeIcons.mars
              : gender == 'female'
                  ? FontAwesomeIcons.venus
                  : FontAwesomeIcons.venusMars),
        ),
        hintText: AppLocalizations.of(context).gender,
      ),
      value: gender,
      items: [
        DropdownMenuItem<String>(
          value: '',
          child: Text(AppLocalizations.of(context).gender),
        ),
        DropdownMenuItem<String>(
          value: 'male',
          child: Text(AppLocalizations.of(context).male),
        ),
        DropdownMenuItem<String>(
          value: 'female',
          child: Text(AppLocalizations.of(context).female),
        ),
      ],
      onChanged: (value) => onGenderChanged(value!),
    );
  }
}
