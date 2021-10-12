import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import 'widgets/change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar:
            AppBar(title: Text(AppLocalizations.of(context).changePassword)),
        body: ChangePasswordForm(),
      ),
    );
  }
}
