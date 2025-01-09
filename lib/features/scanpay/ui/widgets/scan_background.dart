import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class ScanBackground extends StatelessWidget {
  const ScanBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipPath(
      clipper: CenterHoleClipper(
        cutOutSize: theme.sizing.height.s64 + theme.sizing.height.s6,
      ),
      child: Container(color: Colors.black.withAlpha(120)),
    );
  }
}

class CenterHoleClipper extends CustomClipper<Path> {
  final double cutOutSize;

  CenterHoleClipper({required this.cutOutSize});

  @override
  Path getClip(Size size) {
    final path = Path()

      // Add the full rectangle (the overlay)
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the center cutout rectangle
    final center = Offset(size.width / 2, size.height / 2);
    final cutOutRect = Rect.fromCenter(
      center: center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Subtract the center cutout (to make it transparent)
    path
      ..addRRect(RRect.fromRectAndRadius(cutOutRect, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd; // Make the center transparent

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
