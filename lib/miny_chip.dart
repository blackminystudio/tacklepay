import 'package:flutter/material.dart';
import 'theme/theme.dart';

class MinyChip extends StatefulWidget {
  final String label;
  final bool selected;
  final void Function(bool value)? onSelected;

  /// A custom chip widget with selectable functionality.
  ///
  /// [label] is the text displayed on the chip.
  /// [selected] determines whether the chip is initially selected.
  /// [onSelected] is a callback that is triggered when the selection state
  ///  changes.
  const MinyChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  @override
  State<MinyChip> createState() => _MinyChipState();
}

class _MinyChipState extends State<MinyChip> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    // We store 'selected' in the state because it can change over time
    // based on user interaction, so we need to track it within the state
    // to trigger re-renders when it changes.
    selected = widget.selected;
  }

  void _onTap() {
    setState(() {
      selected = !selected;
    });
    widget.onSelected?.call(selected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.onSelected == null;

    return GestureDetector(
      onTap: isDisabled ? null : _onTap,
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
              widget.label,
              style: theme.textStyle.caption.copyWith(
                color:
                    selected ? theme.colors.light : theme.colors.contrastDark,
              ),
            ),
            _buildSelectedIcon(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(ThemeData theme) {
    if (!selected) return const SizedBox.shrink();
    return Row(
      children: [
        SizedBox(width: theme.spacing.width.s4),
        Icon(
          Icons.check,
          size: theme.sizing.width.s3,
          color: theme.colors.light,
        ),
      ],
    );
  }
}
