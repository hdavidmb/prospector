import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/admob/application/ad_state.dart';
import '../../../../../features/admob/application/ads_providers.dart';
import '../../../../../features/contacts/domain/entity/contact_entity.dart';
import 'logic/contact_form_provider.dart';
import 'widgets/contact_form.dart';
import 'widgets/contacts_admob_banner.dart';

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
              ? AppLocalizations.of(context).editProspect
              : AppLocalizations.of(context).newProspect),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: ContactForm(editingContact: editingContact),
                ),
                if (editingContact == null &&
                    shouldShowAds &&
                    bannerState.isLoaded)
                  const ContactsAdmobBanner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
