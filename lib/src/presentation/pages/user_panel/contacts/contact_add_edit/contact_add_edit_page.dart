import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/admob/application/ad_state.dart';
import '../../../../../features/admob/application/ads_providers.dart';
import '../../../../../features/contacts/domain/entity/contact_entity.dart';
import 'logic/contact_form_provider.dart';
import 'widgets/contact_form.dart';
import 'widgets/contacts_admob_banner.dart';

class ContactAddEditPage extends StatefulWidget {
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
  _ContactAddEditPageState createState() => _ContactAddEditPageState();
}

class _ContactAddEditPageState extends State<ContactAddEditPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        if (widget.editingContact != null) {
          context
              .read(contactFormProvider.notifier)
              .setEditingState(editingContact: widget.editingContact!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final bool shouldShowAds = watch(showAds);
        final AdState bannerState = watch(adsProvider).contactsBannerState;
        return WillPopScope(
          onWillPop: () async {
            context.read(contactFormProvider.notifier).reset();
            return true;
          },
          child: Scaffold(
            //TODO: add save button on appbar
            appBar: AppBar(
              title: Text(widget.editingContact != null
                  ? AppLocalizations.of(context).editProspect
                  : AppLocalizations.of(context).newProspect),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ContactForm(editingContact: widget.editingContact),
                    ),
                    if (widget.editingContact == null &&
                        shouldShowAds &&
                        bannerState.isLoaded)
                      const ContactsAdmobBanner(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
