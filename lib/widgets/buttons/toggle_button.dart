import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class MinyToggleButton extends StatefulWidget {
  final bool value;
  final void Function(bool value) onChanged;

  MinyToggleButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<MinyToggleButton> createState() => _MinyToggleButtonState();
}

class _MinyToggleButtonState extends State<MinyToggleButton> {
  late bool value;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            value = !value;
          });
          widget.onChanged(value);
        },
        child: AnimatedContainer(
          height: theme.sizing.height.s8,
          width: theme.sizing.width.s17,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: theme.colors.contrastLight,
            borderRadius: BorderRadius.circular(
              theme.borderradius.medium,
            ),
          ),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: theme.sizing.height.s8,
            width: theme.sizing.width.s12,
            decoration: BoxDecoration(
              color: value ? theme.colors.primary : theme.colors.secondary,
              borderRadius: BorderRadius.circular(
                theme.borderradius.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
