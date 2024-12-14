import 'package:flutter/material.dart';
import '/theme/theme.dart';

class TagTile extends StatefulWidget {
  final String tagName;
  final bool isChecked;

  TagTile({
    required this.tagName,
    this.isChecked = false,
  });

  @override
  State<TagTile> createState() => _TagTileState();
}

class _TagTileState extends State<TagTile> {
  late bool _isChecked;
  late TextEditingController _controller;
  bool _isEditing = false;
  String _originalText = '';

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
    _controller = TextEditingController(text: widget.tagName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCheckbox(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _onSubmitted(String value) {
    setState(() {
      _originalText = value;
      _isEditing = false;
      if (_controller.text.length > 15) {
        _controller
          ..text = '${_controller.text.substring(0, 15)}...'
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
      }
    });
  }

  void _onTapOutside(PointerDownEvent value) {
    setState(() {
      _isEditing = false;
    });
    _controller.clear();
  }

  void _onTap() {
    _controller
      ..text = _originalText
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: _isEditing
          ? TextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: _onSubmitted,
              onTapOutside: _onTapOutside,
              onTap: _onTap,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
              ),
            )
          : Text(
              _controller.text,
              style: theme.textStyle.labelRegular.copyWith(
                color: _isChecked
                    ? theme.colors.contrastDark
                    : theme.colors.contrastMedium,
              ),
            ),
      trailing: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.borderradius.xSmall),
        ),
        value: _isChecked,
        onChanged: (value) => _toggleCheckbox(value ?? false),
        activeColor: theme.colors.contrastDark,
        checkColor: theme.colors.contrastLight,
      ),
      onTap: _toggleEditMode,
    );
  }
}
