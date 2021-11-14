import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/presentation/core/widgets/no_contatcs_screen/info_message_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/widgets/membership_body_selector.dart';
import 'package:prospector/src/presentation/core/widgets/loading_page_cover.dart';

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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AutoRouter.of(context).pop(),
            color: isDarkMode ? Colors.white : Colors.black87,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MembershipBodySelector(iapState: iapState),
    );
  }
}
