import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../features/admob/application/ad_state.dart';
import '../../../../../features/admob/application/ads_providers.dart';
import '../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../core/keyboard_visibility_builder/keyboard_visibility_builder.dart';
import 'logic/contact_form_provider.dart';
import 'widgets/contact_form.dart';

class ContactAddEditPage extends ConsumerWidget {
  /// Pass the contact to be edited
  ///
  /// ** If editingContact is set. You must first call setEditingState on contactFormProvider**
  final Contact? editingContact;

  /// ## Page to add or edit contacts
  ///
  /// **WARNING** If editingContact is set. You must call setEditingState on contactFormProvider before Navigating to this page
  ///
  const ContactAddEditPage({
    Key? key,
    this.editingContact,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool shouldShowAds = watch(showAds);
    final AdState bannerState = watch(adsProvider).contactsBannerState;
    return WillPopScope(
      onWillPop: () async {
        context.read(contactFormProvider.notifier).reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(editingContact != null
              ? AppLocalizations.of(context)!.editProspect
              : AppLocalizations.of(context)!.newProspect),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                ContactForm(editingContact: editingContact),
                if (shouldShowAds && bannerState.isLoaded)
                  KeyboardVisibilityBuilder(
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
