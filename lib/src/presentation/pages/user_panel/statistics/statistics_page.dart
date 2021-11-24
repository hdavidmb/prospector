import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';

import 'widgets/prospects_per_list_chart_card.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key? key,
  }) : super(key: key);

  double get cardElevation => 5.0;
  EdgeInsets get cardMargins => const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0);
  RoundedRectangleBorder get cardShape => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)));
  Duration get animationDuration => const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).statistics),
      ),
      // backgroundColor: Colors.grey[200],
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProspectsPerListChartCard(
            cardElevation: cardElevation,
            cardMargins: cardMargins,
            cardShape: cardShape,
            animationDuration: animationDuration,
          )
        ],
      ),
    );
  }
}
