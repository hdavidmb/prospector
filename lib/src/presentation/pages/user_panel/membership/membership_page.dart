import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../../features/in_app_purchase/application/fetch_state.dart';
import '../../../../features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'widgets/membership_body_selector.dart';

class MembershipPage extends ConsumerWidget {
  const MembershipPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final FetchState iapState = watch(inAppPurchaseNotifier).iapState;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: iapState.isReady
            ? Text(
                AppLocalizations.of(context).prospectorPremium,
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              )
            : null,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AutoRouter.of(context).pop(),
            color: isDarkMode ? Colors.white70 : Colors.black87,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MembershipBodySelector(iapState: iapState),
    );
  }
}
