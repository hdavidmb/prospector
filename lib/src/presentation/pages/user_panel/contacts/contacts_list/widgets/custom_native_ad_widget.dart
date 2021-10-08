import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../features/admob/application/ad_state.dart';
import '../../../../../../features/admob/application/ads_providers.dart';
import 'shimmer_tile.dart';

class CustomNativeAdWidget extends ConsumerWidget {
  final String status;
  final int index;

  const CustomNativeAdWidget({
    required this.status,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _ad =
        context.read(adsProvider).getNativeAd(status: status, index: index);

    final AdState? adState = watch(adsProvider).nativeAdsMap[status]
        ?[index.toString()]?['state'] as AdState?;

    if (adState != null && adState.isLoaded) {
      return Container(
        height: 72.0,
        alignment: Alignment.center,
        child: AdWidget(ad: _ad),
      );
    } else {
      return const ShimmerTile();
    }
  }
}
