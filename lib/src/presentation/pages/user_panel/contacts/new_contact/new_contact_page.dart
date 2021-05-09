import 'package:flutter/material.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/widgets/new_contact_form.dart';

class NewContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('New prospect'), //TODO localize
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: NewContactForm(),
        ),
      ),
    );
  }
}
