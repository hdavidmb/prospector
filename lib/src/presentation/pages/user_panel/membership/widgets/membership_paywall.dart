import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_notifier.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';

import 'package:prospector/src/presentation/pages/user_panel/membership/logic/membership_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/widgets/package_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/widgets/premium_carousel.dart';

class MembershipPaywall extends StatelessWidget {
  const MembershipPaywall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final String firstBillDate =
        localizedMonthDay(DateTime.now().add(const Duration(days: 7)));
    return ProviderListener<InAppPurchaseNotifier>(
      provider: inAppPurchaseNotifier,
      onChange: (context, provider) {
        provider.purchaseFailure.fold(
          () => null,
          (failure) => failure.maybeWhen(
            cancelledByUser: () {},
            orElse: () => showFailureSnackbar(context, failure),
          ),
        );
        provider.purchaseState.maybeWhen(
          ready: () async {
            // TODO: show thanks message
            await showMessageDialog(
              context: context,
              title: '🎊 CONGRATS 🎊', // TODO: localize
              message:
                  "You are now a Prospector Premium user and now you have unlimited access to all the usefull features Prospector has to grow your bussiness.\nThanks for trusting us to help you in your journey. Let's take your bussiness to the next level 🚀",
            );
            Future.delayed(Duration.zero, () => AutoRouter.of(context).pop());
            // TODO: pop view
          },
          orElse: () {},
        );
      },
      child: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: PremiumCarousel(),
            ),
            const SizedBox(height: 25.0),
            const PackageSelector(),
            if (!context.read(inAppPurchaseNotifier).hasPurchasedBefore)
              Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 4.0),
                child: Text(
                  //TODO: hide free trial message if user had purchased before
                  AppLocalizations.of(context).freeTrialMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            const SizedBox(height: 18.0),
            Consumer(builder: (context, watch, child) {
              final FetchState purchaseState =
                  watch(inAppPurchaseNotifier).purchaseState;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(screenSize.width * 0.8, 40.0)),
                onPressed: purchaseState.isFetching
                    ? null
                    : () {
                        final int selectedIndex =
                            watch(membershipNotifierProvider).selectedIndex;
                        context
                            .read(inAppPurchaseNotifier)
                            .purchasePackage(selectedIndex: selectedIndex);
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).continueText,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    if (purchaseState.isFetching) ...[
                      const SizedBox(width: 8.0),
                      const CircularProgressIndicator.adaptive(),
                    ]
                  ],
                ),
              );
            }),
            //TODO: add message for when user is changeing subscription telling that the new sub starts when the current ends
            Consumer(builder: (context, watch, child) {
              final String currencyCode = context
                  .read(inAppPurchaseNotifier)
                  .packages
                  .first
                  .currencyCode;
              final int selectedIndex =
                  watch(membershipNotifierProvider).selectedIndex;
              final String selectedPeriod = watch(inAppPurchaseNotifier)
                  .packages[selectedIndex]
                  .type
                  .everyText;

              final bool hasPurchasedBefore =
                  watch(inAppPurchaseNotifier).hasPurchasedBefore;

              final String firstBilling = hasPurchasedBefore
                  ? ''
                  : '${AppLocalizations.of(context).firstBill} $firstBillDate. ';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  height: 50.0,
                  child: Text(
                    '$firstBilling${AppLocalizations.of(context).renewAutomatically} $selectedPeriod\n${AppLocalizations.of(context).pricesShownIn} $currencyCode.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                ),
              );
            }),
            TextButton(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
              onPressed: () {
                //TODO: implement
                print('RESTORE');
              },
              child: Text(
                AppLocalizations.of(context).restoreMembership,
                style: const TextStyle(
                    color: Colors.grey, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
