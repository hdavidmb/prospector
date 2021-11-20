import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/in_app_purchase/application/fetch_state.dart';
import '../../../../../features/in_app_purchase/application/in_app_purchase_providers.dart';
import '../../../../core/widgets/loading_page_cover.dart';
import '../../../../core/widgets/no_contatcs_screen/info_message_page.dart';
import 'membership_paywall.dart';

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
      ready: () => const MembershipPaywall(),
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
      ),
    );
  }
}
