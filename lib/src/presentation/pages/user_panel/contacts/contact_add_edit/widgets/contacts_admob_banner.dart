import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../features/admob/application/ads_providers.dart';
import '../../../../../core/keyboard_visibility/keyboard_visibility.dart';

class ContactsAdmobBanner extends ConsumerWidget {
  const ContactsAdmobBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return KeyboardVisibility(
      keyboardHiddenChild: Positioned.fill(
        bottom: 20.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: AdWidget(
              ad: context.read(adsProvider).contactsBanner,
            ),
          ),
        ),
      ),
    );
  }
}
