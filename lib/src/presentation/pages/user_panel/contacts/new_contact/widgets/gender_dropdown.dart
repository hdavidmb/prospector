import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          child: FaIcon(FontAwesomeIcons.venusMars),
        ),
        hintText: AppLocalizations.of(context)!.gender,
      ),
      value: gender,
      items: [
        DropdownMenuItem<String>(
          value: '',
          child: Text(AppLocalizations.of(context)!.gender),
        ),
        DropdownMenuItem<String>(
          value: 'male',
          child: Text(AppLocalizations.of(context)!.male),
        ),
        DropdownMenuItem<String>(
          value: 'female',
          child: Text(AppLocalizations.of(context)!.female),
        ),
      ],
      onChanged: (value) => onGenderChanged(value!),
    );
  }
}
