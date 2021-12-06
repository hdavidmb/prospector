import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/keyboard_visibility/keyboard_visibility.dart';

import '../../../routes/app_router.gr.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/home_body_selector.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeBodySelector(),
      floatingActionButton: KeyboardVisibility(
        keyboardHiddenChild: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {
            AutoRouter.of(context).push(ContactAddEditMaterialRoute());
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
