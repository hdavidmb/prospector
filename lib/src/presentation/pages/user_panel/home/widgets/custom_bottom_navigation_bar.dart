import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/user/application/user_info_providers.dart';
import '../../../../routes/app_router.gr.dart';
import '../logic/home_index_provider.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final int currentIndex = watch(homeIndexProvider).index;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 8.0,
      child: Row(
        children: [
          CustomBottomBarButton(
            position: 0,
            currentIndex: currentIndex,
            iconData: Icons.insert_chart,
            label: AppLocalizations.current.statistics,
          ),
          CustomBottomBarButton(
            position: 1,
            currentIndex: currentIndex,
            iconData: Icons.people,
            label: AppLocalizations.current.prospects,
          ),
          const Expanded(child: SizedBox()),
          CustomBottomBarButton(
            position: 2,
            currentIndex: currentIndex,
            iconData: Icons.event,
            label: AppLocalizations.current.events,
          ),
          CustomBottomBarButton(
            position: 3,
            currentIndex: currentIndex,
            iconData: Icons.settings,
            label: AppLocalizations.current.settings,
          ),
        ],
      ),
    );
  }
}

class CustomBottomBarButton extends StatelessWidget {
  final int position;
  final int currentIndex;
  final IconData iconData;
  final String label;
  const CustomBottomBarButton({
    Key? key,
    required this.position,
    required this.currentIndex,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSelected = currentIndex == position;
    final Color selectedColor = Theme.of(context).primaryColor;
    final Color? unselectedColor =
        isDarkMode ? Colors.white70 : Colors.grey[600];
    return GestureDetector(
      onTap: isSelected
          ? null
          : () {
              final bool isPremium =
                  context.read(userInfoNotifierProvider).isPremiumUser;
              if (position == 0 && !isPremium) {
                AutoRouter.of(context).push(const MembershipRoute());
                return;
              }
              context.read(homeIndexProvider).index = position;
            },
      child: Container(
        // Transparent color is to ensure the gesture detector acts on the entire container
        color: Colors.transparent,
        height: 56.0,
        width: screenSize.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            const SizedBox(height: 2.0),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.0,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
