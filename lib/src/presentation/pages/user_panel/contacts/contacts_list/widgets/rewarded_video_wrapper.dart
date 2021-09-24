import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../features/admob/application/ad_state.dart';
import 'rewarded_video_header.dart';

import '../../../../../../features/admob/application/ads_providers.dart';
import 'shimmer_tile.dart';

class RewardedVideoWrapper extends ConsumerWidget {
  const RewardedVideoWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool shouldShowAds = watch(showAds);
    final AdState rewardedVideoState = watch(adsProvider).rewardedVideoState;
    if (shouldShowAds) {
      if (rewardedVideoState.isLoaded) {
        return const RewardedVideoHeader();
      } else if (!rewardedVideoState.isError) {
        return const ShimmerTile(isHeader: true);
      }
    }
    return const SizedBox();
  }
}
