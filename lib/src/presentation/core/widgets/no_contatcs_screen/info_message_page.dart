import 'package:flutter/material.dart';

class InfoMessagePage extends StatelessWidget {
  final String imagePath;
  final double imageHeight;
  final String message;
  final EdgeInsetsGeometry padding;
  final Widget? action;

  const InfoMessagePage({
    Key? key,
    required this.imagePath,
    required this.imageHeight,
    required this.message,
    this.padding = const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
    this.action,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Image(image: AssetImage(imagePath), height: imageHeight),
            const SizedBox(height: 22.0, width: double.infinity),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
