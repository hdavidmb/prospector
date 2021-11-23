import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).statistics),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [],
      ),
    );
  }
}
