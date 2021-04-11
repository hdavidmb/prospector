import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener<AuthState>(
        provider: authStateNotifierProvider.state,
        onChange: (context, authState) {
          authState.maybeWhen(
            authenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())), //TODO implement proper navigation or routing
            orElse: () {},
          );
        },
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Hero(tag: 'prospector_logo', child: Image(image: AssetImage('assets/images/prospector_logo.png'), width: 100.0)),
                  Text(AppLocalizations.of(context).welcomeTo,
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 8.0),
                  Text(AppLocalizations.of(context).prospector,
                      style: Theme.of(context).textTheme.headline3. copyWith(color: Colors.black87)),
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
