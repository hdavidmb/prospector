import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'widgets/effectiveness_chart_card.dart';
import 'widgets/month_actions_chart_card.dart';
import 'widgets/prospects_per_list_chart_card.dart';
import 'widgets/turn_down_chart_card.dart';

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProspectsPerListChartCard(
            cardElevation: cardElevation,
            cardMargins: cardMargins,
            cardShape: cardShape,
            animationDuration: animationDuration,
          ),
          MonthActionsChartCard(
            cardElevation: cardElevation,
            cardMargins: cardMargins,
            cardShape: cardShape,
            animationDuration: animationDuration,
          ),
          EffectivenessChartCard(
            cardElevation: cardElevation,
            cardMargins: cardMargins,
            cardShape: cardShape,
            animationDuration: animationDuration,
          ),
          TurnDownChartCard(
            cardElevation: cardElevation,
            cardMargins: cardMargins,
            cardShape: cardShape,
            animationDuration: animationDuration,
          ),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
