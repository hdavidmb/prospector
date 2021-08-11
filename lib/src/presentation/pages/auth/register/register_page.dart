import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_state/app_state.dart';
import '../../../core/app_state/app_state_provider.dart';
import '../../../core/dialogs.dart';
import '../../../routes/app_router.gr.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showingDialog = false;
    return Scaffold(
      body: ProviderListener<AppState>(
        provider: appStateNotifierProvider,
        onChange: (context, appState) async {
          if (appState == const AppState.authenticatedReady()) {
            AutoRouter.of(context).replace(const HomeRoute());
          } else if (appState == const AppState.error()) {
            if (!showingDialog) {
              showingDialog = true;
              await showMessageDialog(
                  context: context,
                  message: AppLocalizations.of(context)!.appStateError);
              showingDialog = false;
            }
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
