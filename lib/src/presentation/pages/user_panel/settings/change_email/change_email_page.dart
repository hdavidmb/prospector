import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/change_email/widgets/change_email_form.dart';

class ChangeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.changeEmail)),
        body: ChangeEmailForm(),
      ),
    );
  }
}
