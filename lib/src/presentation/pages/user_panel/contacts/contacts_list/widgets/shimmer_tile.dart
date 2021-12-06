import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  final bool isHeader;
  const ShimmerTile({
    Key? key,
    this.isHeader = false,
  }) : super(key: key);

  static const double barHeight = 8.0;
  static const double spacing = 6.0;
  static const double circleSize = 60.0;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isHeader
          ? isDarkTheme
              ? Colors.grey[800]
              : Colors.grey[200]
          : null,
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
        highlightColor: isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!,
        child: Row(
          children: [
            Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(circleSize / 2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: barHeight,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: spacing),
                    Container(
                      height: barHeight,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: spacing),
                    Container(
                      height: barHeight,
                      width: 60.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
