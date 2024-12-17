import 'dart:async';

import 'package:flutter/material.dart';
import '/theme/theme.dart';
import 'string_constants.dart';

class TagTile extends StatefulWidget {
  final String tagName;
  final bool isSelected;
  final Function(bool value) onSelection;
  final Function(String value) onSaveTag;
  final int maxLength;

  TagTile({
    required this.tagName,
    this.isSelected = false,
    required this.onSelection,
    required this.onSaveTag,
    this.maxLength = 15,
  });

  @override
  State<TagTile> createState() => _TagTileState();
}

class _TagTileState extends State<TagTile> {
  late bool _isTagSelected;
  bool _isEditingTagName = false;
  late TextEditingController _tagNameController;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _isTagSelected = widget.isSelected;
    _tagNameController = TextEditingController(text: widget.tagName);
    // Update the counter in realtime
    _tagNameController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        setState(() {}); // Update character count after debounce
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tagNameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditingTagName = true;
    });
    _focusNode.requestFocus();
  }

  void _discardChanges() {
    setState(() {
      _tagNameController.text = widget.tagName;
      _isEditingTagName = false;
    });
    _focusNode.unfocus();
  }

  void _onSubmitted(String value, ThemeData theme) {
    final trimmedValue = value.trim(); // Trim extra spaces
    if (trimmedValue.isNotEmpty && trimmedValue != widget.tagName) {
      widget.onSaveTag(trimmedValue);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tagUpdated, style: theme.textStyle.bodyBold),
          duration: const Duration(seconds: 1),
          backgroundColor: theme.colors.contrastDark,
        ),
      );
    } else {
      // Reset if input is empty
      _tagNameController.text = widget.tagName;
    }
    setState(() {
      _isEditingTagName = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _isEditingTagName
                ? _buildTagTextfield(theme)
                : _buildTagShowText(theme),
          ),
          _buildCheckBox(theme),
        ],
      ),
    );
  }

  Widget _buildTagTextfield(ThemeData theme) => Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              autofocus: true,
              onSubmitted: (value) => _onSubmitted(value, theme),
              maxLength: widget.maxLength,
              controller: _tagNameController,
              onTapOutside: (_) => _discardChanges(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: emptyString,
                isCollapsed: true,
              ),
              style: theme.textStyle.labelRegular.copyWith(
                color: _isTagSelected
                    ? theme.colors.contrastDark
                    : theme.colors.contrastMedium,
              ),
            ),
          ),
          Text(
            '${_tagNameController.text.length} / ${widget.maxLength}',
            style: theme.textStyle.caption.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );

  SizedBox _buildCheckBox(ThemeData theme) => SizedBox(
        width: theme.sizing.width.s8,
        height: theme.sizing.width.s8,
        child: Checkbox(
          value: _isTagSelected,
          checkColor: theme.colors.contrastLight,
          activeColor: theme.colors.contrastDark,
          onChanged: (value) {
            setState(() {
              _isTagSelected = value ?? false;
            });
            widget.onSelection(_isTagSelected);
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              theme.borderradius.xSmall,
            ),
          ),
        ),
      );

  GestureDetector _buildTagShowText(ThemeData theme) => GestureDetector(
        onTap: _toggleEditMode,
        child: Container(
          margin: EdgeInsets.only(right: theme.sizing.width.s10),
          color: theme.colors.light,
          child: Text(
            widget.tagName,
            style: theme.textStyle.labelRegular.copyWith(
              color: _isTagSelected
                  ? theme.colors.contrastDark
                  : theme.colors.contrastMedium,
            ),
          ),
        ),
      );
}
