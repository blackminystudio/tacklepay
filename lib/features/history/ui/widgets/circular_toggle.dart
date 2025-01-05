import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';

class CircularToggle extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CircularToggle({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: theme.sizing.width.s5,
        height: theme.sizing.width.s5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected ? theme.colors.contrastDark : theme.colors.contrastLow,
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: theme.sizing.width.s5 / 2,
                  height: theme.sizing.width.s5 / 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colors.contrastLight,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
