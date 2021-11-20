import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';

class PremiumCarousel extends StatefulWidget {
  const PremiumCarousel({
    Key? key,
  }) : super(key: key);

  @override
  _PremiumCarouselState createState() => _PremiumCarouselState();
}

class _PremiumCarouselState extends State<PremiumCarousel> {
  //TODO: add item for call and text feature
  final List<Map<String, String>> items = [
    {
      'image_path': 'assets/images/report_mobile.png',
      'title': AppLocalizations.current.statisticsModule,
      'message': AppLocalizations.current.statisticsModuleMessage,
    },
    {
      'image_path': 'assets/images/all_the_data.png',
      'title': AppLocalizations.current.measureWhatMatters,
      'message': AppLocalizations.current.measureWhatMattersMessage,
    },
    {
      'image_path': 'assets/images/projections.png',
      'title': AppLocalizations.current.planToImprove,
      'message': AppLocalizations.current.planToImproveMessage,
    },
    {
      'image_path': 'assets/images/remove_ads.png',
      'title': AppLocalizations.current.removeAds,
      'message': AppLocalizations.current.removeAdsMessage,
    },
  ];
  int _currentPage = 100 * 4;
  PageController? controller;
  Timer? timer;

  void setTimer() {
    if (timer?.isActive == true) timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 8), (Timer _timer) {
      _currentPage++;

      controller!.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _currentPage);
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (page) {
        _currentPage = page;
        setTimer();
      },
      itemBuilder: (context, index) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(items[index % 4]['image_path']!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              items[index % 4]['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              items[index % 4]['message']!,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    timer?.cancel();
    super.dispose();
  }
}
