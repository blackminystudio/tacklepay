import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class ScanOverlayAnimation extends StatefulWidget {
  const ScanOverlayAnimation({super.key});

  @override
  State<ScanOverlayAnimation> createState() => _ScanOverlayAnimationState();
}

class _ScanOverlayAnimationState extends State<ScanOverlayAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 200, end: 250).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) => Center(
        child: CustomPaint(
          size: Size(_sizeAnimation.value, _sizeAnimation.value),
          painter: CornerBoxPaint(
            color: theme.colors.light,
            strokeWidth: theme.spacing.height.s8,
            cornerRadius: theme.borderradius.medium,
            cornerLength: theme.sizing.height.s10,
          ),
        ),
      ),
    );
  }
}

class CornerBoxPaint extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerRadius;
  final double cornerLength;

  CornerBoxPaint({
    required this.color,
    required this.strokeWidth,
    required this.cornerRadius,
    required this.cornerLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()

      // Top-left corner
      ..moveTo(0, cornerLength)
      ..lineTo(0, cornerRadius)
      ..arcToPoint(Offset(cornerRadius, 0),
          radius: Radius.circular(cornerRadius))
      ..lineTo(cornerLength, 0)

      // Top-right corner
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(
        Offset(size.width, cornerRadius),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(size.width, cornerLength)

      // Bottom-right corner
      ..moveTo(size.width, size.height - cornerLength)
      ..lineTo(size.width, size.height - cornerRadius)
      ..arcToPoint(
        Offset(size.width - cornerRadius, size.height),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(size.width - cornerLength, size.height)

      // Bottom-left corner
      ..moveTo(cornerLength, size.height)
      ..lineTo(cornerRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - cornerRadius),
        radius: Radius.circular(cornerRadius),
      )
      ..lineTo(0, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
