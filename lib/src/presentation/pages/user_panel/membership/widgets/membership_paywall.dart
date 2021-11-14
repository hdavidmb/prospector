import 'package:flutter/material.dart';
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
            'SUBSCRIBE', //TODO: localize
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
              'Restore subscription',
              style: const TextStyle(
                  color: Colors.grey, decoration: TextDecoration.underline),
            ), //TODO: localize
          ),
        ),
      ],
    );
  }
}
