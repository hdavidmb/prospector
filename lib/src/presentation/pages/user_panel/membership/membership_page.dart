import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/widgets/membership_body_selector.dart';
import 'package:prospector/src/presentation/core/widgets/loading_page_cover.dart';

class MembershipPage extends ConsumerWidget {
  const MembershipPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final FetchState iapState = watch(inAppPurchaseNotifier).iapState;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            // TODO: set color deppending on themeMode
            onPressed: () => AutoRouter.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MembershipBodySelector(iapState: iapState),
    );
  }
}
