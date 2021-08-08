import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../features/admob/application/ads_providers.dart';
import '../../../../../core/keyboard_visibility_builder/keyboard_visibility_builder.dart';

class ContactsAdmobBanner extends ConsumerWidget {
  const ContactsAdmobBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return KeyboardVisibilityBuilder(
      builder: (context, child, isKeyboardVisible) =>
          isKeyboardVisible ? const SizedBox() : child,
      child: Positioned.fill(
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
