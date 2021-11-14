import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';

import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/presentation/core/widgets/loading_page_cover.dart';
import 'package:prospector/src/presentation/core/widgets/no_contatcs_screen/info_message_page.dart';

class MembershipBodySelector extends StatelessWidget {
  final FetchState iapState;
  const MembershipBodySelector({
    Key? key,
    required this.iapState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return iapState.when(
      initial: () {
        context.read(inAppPurchaseNotifier).logInPurchaser();
        context.read(inAppPurchaseNotifier).getPackages();
        return LoadingPageCover();
      },
      fetching: () => LoadingPageCover(),
      ready: () => Center(), // TODO: implement paywall page
      error: () => InfoMessagePage(
        imagePath: 'assets/images/error.png',
        imageHeight: 150.0,
        message: AppLocalizations.of(context).serverError,
        centerContent: true,
        action: ElevatedButton(
          onPressed: () {
            context.read(inAppPurchaseNotifier).logInPurchaser();
            context.read(inAppPurchaseNotifier).getPackages();
          },
          child: Text(AppLocalizations.of(context).tryAgain),
        ),
      ), // TODO: implement error page
    );
  }
}
