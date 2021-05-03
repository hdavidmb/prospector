import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/change_password/widgets/change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.changePassword)),
        body: ChangePasswordForm(),
      ),
    );
  }
}