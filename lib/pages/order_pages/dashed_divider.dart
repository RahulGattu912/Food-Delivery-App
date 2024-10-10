import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.dashWidth = 5,
    this.color = const Color(0xFFA1A1A1),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
