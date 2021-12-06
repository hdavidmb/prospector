import 'package:auto_route/auto_route.dart';
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
  final Contact? editingContact;
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
            appBar: AppBar(
              automaticallyImplyLeading: widget.editingContact != null,
              title: Text(widget.editingContact != null
                  ? AppLocalizations.of(context).editProspect
                  : AppLocalizations.of(context).newProspect),
              actions: widget.editingContact == null
                  ? [
                      IconButton(
                          onPressed: () => AutoRouter.of(context).pop(),
                          icon: const Icon(Icons.close))
                    ]
                  : null,
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
