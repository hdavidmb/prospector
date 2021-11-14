import 'package:flutter/material.dart';

import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/presentation/core/widgets/loading_page_cover.dart';

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
      ready: () => Center(),
      error: () => Center(), // TODO: implement error page
    );
  }
}
