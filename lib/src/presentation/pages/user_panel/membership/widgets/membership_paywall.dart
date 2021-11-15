import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';
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
    return SafeArea(
      child: Column(
        children: [
          const Expanded(
            child: PremiumCarousel(),
          ),
          const SizedBox(height: 25.0),
          const PackageSelector(),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, bottom: 15.0, top: 4.0),
            child: Text(
              AppLocalizations.of(context).freeTrialMessage,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: Size(screenSize.width * 0.8, 40.0)),
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context).continueText,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer(builder: (context, watch, child) {
            final String currencyCode =
                context.read(inAppPurchaseNotifier).packages.first.currencyCode;
            final int selectedIndex =
                watch(membershipNotifierProvider).selectedIndex;
            final String selectedPeriod = watch(inAppPurchaseNotifier)
                .packages[selectedIndex]
                .type
                .everyText;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                height: 50.0,
                child: Text(
                  '${AppLocalizations.of(context).firstBill} $firstBillDate. ${AppLocalizations.of(context).renewAutomatically} $selectedPeriod\n${AppLocalizations.of(context).pricesShownIn} $currencyCode.',
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
    );
  }
}
