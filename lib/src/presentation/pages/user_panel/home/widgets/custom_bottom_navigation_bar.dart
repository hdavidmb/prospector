import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/logic/home_index_provider.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Size screenSize = MediaQuery.of(context).size;
    final int currentIndex = watch(homeIndexProvider).index;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 8.0,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              color: Colors.red,
              height: 56.0,
              width: screenSize.width / 5,
            ),
          ),
          Container(
            color: Colors.yellow,
            height: 56.0,
            width: screenSize.width / 5,
          ),
          Container(
            color: Colors.white,
            height: 56.0,
            width: screenSize.width / 5,
          ),
          Container(
            color: Colors.blue,
            height: 56.0,
            width: screenSize.width / 5,
          ),
          Container(
            color: Colors.red,
            height: 56.0,
            width: screenSize.width / 5,
          ),
        ],
      ),
    );
  }
}
