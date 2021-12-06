import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import 'widgets/change_email_form.dart';

class ChangeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).changeEmail)),
        body: ChangeEmailForm(),
      ),
    );
  }
}
