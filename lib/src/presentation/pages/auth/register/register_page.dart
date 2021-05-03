import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/core/app_state/app_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/home_page.dart';
import 'package:prospector/src/presentation/pages/auth/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener<AppState>(
        provider: appStateNotifierProvider,
        onChange: (context, appState) {
          if (appState == const AppState.authenticatedReady()) {
            Navigator.pushReplacement(
                context, CupertinoPageRoute(builder: (context) => HomePage()));
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                // height: screenSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Hero(
                        tag: 'prospector_logo',
                        child: Image(
                            image:
                                AssetImage('assets/images/prospector_logo.png'),
                            width: 100.0)),
                    Text(AppLocalizations.of(context)!.register,
                        style: const TextStyle(fontSize: 30.0)),
                    const SizedBox(height: 30.0),
                    const RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
