import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Hero(
                      tag: 'prospector_logo',
                      child: Image(
                          image:
                              AssetImage('assets/images/prospector_logo.png'),
                          width: 100.0)),
                  Text(AppLocalizations.of(context).welcomeTo,
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 8.0),
                  Text(AppLocalizations.of(context).prospector,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color:
                              isDarkTheme ? Colors.white70 : Colors.black87)),
                  const SizedBox(height: 30.0),
                  const SignInForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
