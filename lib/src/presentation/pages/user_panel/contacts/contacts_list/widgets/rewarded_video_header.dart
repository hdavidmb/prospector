import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/admob/application/ads_providers.dart';

class RewardedVideoHeader extends StatelessWidget {
  const RewardedVideoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final rewardMinutes = context.read(adsProvider.notifier).rewardMinutes;
    return GestureDetector(
      onTap: context.read(adsProvider).showRewaradedVideo,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
        child: Row(
          children: [
            Icon(
              Icons.play_circle_filled,
              color: Theme.of(context).primaryColor,
              size: 70.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.getRidOfAds,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 15.0),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.watchAShortVideo,
                          ),
                          TextSpan(
                              text:
                                  ' $rewardMinutes ${AppLocalizations.of(context)!.minutes} ', //TODO: get minutes from admob
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .ofProspectorWithNoAds,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
