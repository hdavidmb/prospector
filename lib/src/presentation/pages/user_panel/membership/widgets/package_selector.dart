import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_providers.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package_type.dart';
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
    final double height = isSelected ? 120.0 : 115.0;
    final double monthlyPrice = package.price / package.type.months;
    const Radius radius = Radius.circular(10.0);
    return GestureDetector(
      onTap: () {
        //TODO: select index
        context.read(membershipNotifierProvider).selectedIndex = position;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 2,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                ),
                color: Colors.grey[300]!.withAlpha(isSelected ? 255 : 100),
              ),
              child: Center(
                child: Text(
                  package.priceString,
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: height / 2,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: radius,
                  bottomRight: radius,
                ),
                color: Theme.of(context)
                    .primaryColor
                    .withAlpha(isSelected ? 230 : 30),
              ),
              child: Column(
                children: [
                  Center(
                    child: AutoSizeText(
                      package.priceString,
                      maxLines: 1,
                      minFontSize: isSelected ? 15.0 : 12.0,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withAlpha(50)),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Center(
                    child: AutoSizeText(
                      '${package.priceString[0]}${monthlyPrice.toStringAsFixed(monthlyPrice > 999 ? 0 : 2)} / m',
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
                                  .withAlpha(50)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
