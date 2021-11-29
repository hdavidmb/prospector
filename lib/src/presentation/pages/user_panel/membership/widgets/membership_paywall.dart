import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/analytics/firebase_analytics_providers.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/in_app_purchase/application/fetch_state.dart';
import '../../../../../features/in_app_purchase/application/in_app_purchase_notifier.dart';
import '../../../../../features/in_app_purchase/application/in_app_purchase_providers.dart';
import '../../../../../features/in_app_purchase/domain/entities/iap_package.dart';
import '../../../../../features/in_app_purchase/domain/failures/iap_failure.dart';
import '../../../../../features/user/application/user_info_providers.dart';
import '../../../../core/dialogs.dart';
import '../../../../helpers/date_formatters.dart';
import '../logic/membership_providers.dart';
import 'package_selector.dart';
import 'premium_carousel.dart';

class MembershipPaywall extends StatelessWidget {
  const MembershipPaywall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read(firebaseAnalyticsServiceProvider)
        .logViewMembershipPaywall(); //TODO: test
    final Size screenSize = MediaQuery.of(context).size;
    final String firstBillDate =
        localizedMonthDay(DateTime.now().add(const Duration(days: 7)));
    final bool isPremium = context.read(userInfoNotifierProvider).isPremiumUser;
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
        provider.restoreState.maybeWhen(
          error: () =>
              showFailureSnackbar(context, const IAPFailure.serverError()),
          ready: () {
            if (provider.packageRestored) {
              showMessageDialog(
                  context: context,
                  title: AppLocalizations.of(context).membershipRestored,
                  message: AppLocalizations.of(context)
                      .yourMembershipHasBeenRestored);
            } else {
              showMessageDialog(
                  context: context,
                  message:
                      "${AppLocalizations.of(context).weCoulntFindMembership} ${Platform.isIOS ? AppLocalizations.of(context).appStore : AppLocalizations.of(context).playStore}");
            }
          },
          orElse: () {},
        );
        provider.purchaseState.maybeWhen(
          ready: () async {
            await showMessageDialog(
              context: context,
              title: '🎊 ${AppLocalizations.of(context).congrats} 🎊',
              message:
                  "${AppLocalizations.of(context).purchaseThankMessage} 🚀",
            );
            Future.delayed(Duration.zero, () => AutoRouter.of(context).pop());
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
            if (isPremium ||
                !context.read(inAppPurchaseNotifier).hasPurchasedBefore)
              Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 4.0),
                child: Text(
                  isPremium
                      ? AppLocalizations.of(context)
                          .yourNewSubscriptionWillStart
                      : AppLocalizations.of(context).freeTrialMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            const SizedBox(height: 18.0),
            Consumer(builder: (context, watch, child) {
              final InAppPurchaseNotifier notifier =
                  watch(inAppPurchaseNotifier);
              final FetchState purchaseState = notifier.purchaseState;
              final FetchState restoreState = notifier.restoreState;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(screenSize.width * 0.8, 40.0)),
                onPressed: purchaseState.isFetching || restoreState.isFetching
                    ? null
                    : () {
                        context
                            .read(firebaseAnalyticsServiceProvider)
                            .logTapSubscribeButton(); //TODO: test
                        final int selectedIndex = context
                            .read(membershipNotifierProvider)
                            .selectedIndex;
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
                    if (purchaseState.isFetching ||
                        restoreState.isFetching) ...[
                      const SizedBox(width: 8.0),
                      const CircularProgressIndicator.adaptive(),
                    ]
                  ],
                ),
              );
            }),
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
                context.read(inAppPurchaseNotifier).restorePurchase();
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
