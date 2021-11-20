import 'package:flutter/material.dart';

class LoadingPageCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
