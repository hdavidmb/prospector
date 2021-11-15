import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';

import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package_type.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/helpers/number_formatters.dart';
import 'package:prospector/src/presentation/pages/user_panel/membership/logic/membership_providers.dart';

class PackageSelector extends ConsumerWidget {
  const PackageSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<IAPPackage> packages = watch(inAppPurchaseNotifier).packages;
    final int selectedIndex = watch(membershipNotifierProvider).selectedIndex;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: packages.map((package) {
        final int position = packages.indexOf(package);
        return PackageCell(
          package: package,
          position: position,
          selectedIndex: selectedIndex,
          savings: context.read(membershipNotifierProvider).getPackageSavings(
                price: package.price,
                months: package.type.months,
                basePrice: packages.first.price,
                baseMonths: packages.first.type.months,
              ),
        );
      }).toList(),
    );
  }
}

class PackageCell extends StatelessWidget {
  final IAPPackage package;
  final int selectedIndex;
  final int position;
  final int savings;
  const PackageCell({
    Key? key,
    required this.package,
    required this.selectedIndex,
    required this.position,
    required this.savings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = position == selectedIndex;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double width = isSelected ? 100.0 : 95.0;
    final double height = isSelected ? 115.0 : 110.0;
    final double monthlyPrice = package.price / package.type.months;
    final bool isPremium = context.read(userInfoNotifierProvider).isPremiumUser;
    final String? userSKU =
        context.read(userInfoNotifierProvider).user?.subscriptionSKU;

    return GestureDetector(
      onTap: () {
        context.read(membershipNotifierProvider).selectedIndex = position;
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Card(
            elevation: isSelected ? 10.0 : 2.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.4,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 14.0),
                  color: isSelected
                      ? Colors.grey[350]
                      : isDarkMode
                          ? Colors.white24
                          : Colors.black.withAlpha(25),
                  child: Center(
                    child: Text(
                      package.type.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.6,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 14.0),
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : isDarkMode
                          ? Colors.white10
                          : Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: AutoSizeText(
                          getFormattedPrice(
                              price: package.price,
                              currencyCode: package.currencyCode),
                          maxLines: 1,
                          minFontSize: isSelected ? 15.0 : 12.0,
                          // maxFontSize: isSelected ? 20.0 : 16.0,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withAlpha(50)),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Center(
                        child: AutoSizeText(
                          '${getFormattedPrice(price: monthlyPrice, currencyCode: package.currencyCode)} / m',
                          maxLines: 1,
                          maxFontSize: 12.0,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white70
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withAlpha(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (savings > 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Colors.green[300],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text(
                  '${AppLocalizations.of(context).saveFinancial} $savings%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (isPremium && userSKU == package.sku)
            Positioned(
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.amber[400],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Text(
                    AppLocalizations.of(context).currentText,
                    style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
