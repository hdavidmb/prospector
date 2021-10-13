import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsappButton extends StatelessWidget {
  final String? whatsapp;
  const WhatsappButton({
    Key? key,
    required this.whatsapp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle),
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.whatsapp),
        onPressed: () {}, //TODO text prospect
      ),
    );
  }
}
