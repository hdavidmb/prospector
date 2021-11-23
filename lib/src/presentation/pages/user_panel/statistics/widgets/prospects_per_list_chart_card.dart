import 'package:flutter/material.dart';

class ProspectsPerListChartCard extends StatelessWidget {
  const ProspectsPerListChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
  }) : super(key: key);

  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      margin: cardMargins,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Prospects per list', // TODO: localize
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () {
                    // TODO: chartsService
                    //     .showProspectsChartDescription(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Include 'Not Interested'", //TODO: localize
                  textAlign: TextAlign.end,
                ),
                Switch.adaptive(
                    value: false, //TODO: implement riverpod notifier
                    // activeTrackColor: Colors.green,
                    onChanged: (value) {
                      //TODO: implement with riverpod notifier
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
