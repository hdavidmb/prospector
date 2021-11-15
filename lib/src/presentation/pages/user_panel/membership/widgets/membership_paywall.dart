import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/widgets/package_selector.dart';

class MembershipPaywall extends StatelessWidget {
  const MembershipPaywall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(color: Colors.blue),
        ),
        const PackageSelector(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), minimumSize: Size(300.0, 40.0)),
          onPressed: () {},
          child: Text(
            AppLocalizations.of(context).continueText,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
            'text'), // TODO: implement info message about including 7 days of free trial and auto renewal date
        SafeArea(
          top: false,
          child: TextButton(
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onPressed: () {
              //TODO: implement
              print('RESTORE');
            },
            child: Text(
              AppLocalizations.of(context).restoreSubscription,
              style: const TextStyle(
                  color: Colors.grey, decoration: TextDecoration.underline),
            ), //TODO: localize
          ),
        ),
      ],
    );
  }
}
