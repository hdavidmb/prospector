import 'package:flutter/material.dart';

class PhoneButton extends StatelessWidget {
  final String? phone;
  const PhoneButton({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.phone),
        onPressed: () {}, //TODO call prospect
      ),
    );
  }
}
