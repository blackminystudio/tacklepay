import 'package:flutter/material.dart';
import '../theme/theme.dart';

class MinyChip extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(bool value)? onSelected;

  /// A custom chip widget with selectable functionality.
  ///
  /// [label] is the text displayed on the chip.
  /// [selected] determines whether the chip is initially selected.
  /// [onSelected] is a callback that is triggered when the selection state
  /// changes.
  const MinyChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onSelected == null;

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              if (onSelected != null) {
                onSelected!(!selected); // Pass the updated selection state
              }
            },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.sizing.width.s2,
          horizontal: theme.sizing.width.s3,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(theme.borderradius.large),
          color:
              selected ? theme.colors.contrastDark : theme.colors.contrastLow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textStyle.caption.copyWith(
                color:
                    selected ? theme.colors.light : theme.colors.contrastDark,
              ),
            ),
            if (selected) _buildSelectedIcon(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(ThemeData theme) => Row(
        children: [
          SizedBox(width: theme.spacing.width.s4),
          Icon(
            MinyIcons.check,
            size: theme.sizing.width.s3,
            color: theme.colors.light,
          ),
        ],
      );
}
