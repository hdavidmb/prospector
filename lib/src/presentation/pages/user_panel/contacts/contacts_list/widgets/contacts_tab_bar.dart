import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contacts_group_list.dart';

class ContactsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                child: TabBar(
                  labelColor: Theme.of(context).textTheme.bodyText1!.color,
                  indicatorColor: Theme.of(context).textTheme.bodyText1!.color,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                  tabs: <Widget>[
                    Tab(
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.general,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.invitedP,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.followUp,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.affiliatedP,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0.0),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ContactsGroupList(
              statuses: [
                context.read(appDefaultDataProvider).notContactedID,
                context.read(appDefaultDataProvider).notInterestedID,
              ],
            ),
            ContactsGroupList(
              statuses: [
                context.read(appDefaultDataProvider).invitedID,
              ],
            ),
            ContactsGroupList(
              statuses: [
                context.read(appDefaultDataProvider).followUpID,
              ],
            ),
            ContactsGroupList(
              statuses: [
                context.read(appDefaultDataProvider).clientID,
                context.read(appDefaultDataProvider).executiveID,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
