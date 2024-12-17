import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'widgets/string_constants.dart';

enum TagType {
  info,
  create,
}

class TagCard extends StatefulWidget {
  final String? text;
  final TagType tagType;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final ValueChanged<String>? onTextSubmit;

  const TagCard({
    super.key,
    this.text,
    this.onTap,
    this.onDelete,
    this.onTextSubmit,
    required this.tagType,
  });

  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  bool isEditing = false;
  final TextEditingController _controller = TextEditingController();

  void _onSubmitted(String value) {
    final text = value.replaceAll(' ', '');
    if (text.isNotEmpty) {
      widget.onTextSubmit?.call(text);
    }
    _clearField();
  }

  void _clearField() {
    setState(() {
      isEditing = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.tagType == TagType.create && isEditing) {
      return _buildDottedBorderWrapper(
        theme: theme,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.sizing.width.s5,
          ),
          decoration: BoxDecoration(
            color: theme.colors.contrastLow,
            borderRadius: BorderRadius.circular(
              theme.borderradius.xLarge,
            ),
          ),
          width: theme.sizing.width.s28,
          height: theme.sizing.height.s11,
          child: Center(
            child: TextField(
              autofocus: true,
              controller: _controller,
              onSubmitted: _onSubmitted,
              onTapOutside: (_) => _clearField(),
              decoration: _buildInputDecoration(theme),
              style: theme.textStyle.bodyBold.copyWith(
                color: theme.colors.contrastDark,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.tagType == TagType.create
          ? () => setState(() => isEditing = true)
          : widget.onTap,
      child: widget.tagType == TagType.create
          ? _buildDottedBorderWrapper(
              theme: theme,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colors.contrastLow,
                  borderRadius: BorderRadius.circular(
                    theme.borderradius.xLarge,
                  ),
                ),
                width: theme.sizing.width.s28,
                height: theme.sizing.height.s11,
                child: Center(
                  child: Text(
                    addTagText,
                    style: theme.textStyle.bodyBold.copyWith(
                      color: theme.colors.contrastDark,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: theme.colors.contrastLow,
                borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
              ),
              constraints: BoxConstraints(maxWidth: theme.sizing.width.s64),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: theme.sizing.width.s3,
                        left: theme.sizing.width.s4,
                        bottom: theme.sizing.width.s3,
                      ),
                      child: Text(
                        widget.text ?? '',
                        style: theme.textStyle.bodyBold.copyWith(
                          color: theme.colors.contrastDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  _buildCrossButton(theme),
                ],
              ),
            ),
    );
  }

  InputDecoration _buildInputDecoration(ThemeData theme) => InputDecoration(
        hintStyle: theme.textStyle.bodyBold.copyWith(
          color: theme.colors.contrastDark,
        ),
        isCollapsed: true,
        hintText: addTagText,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s2,
        ),
      );

  DottedBorder _buildDottedBorderWrapper({
    required Widget child,
    required ThemeData theme,
  }) =>
      DottedBorder(
        strokeWidth: 2,
        dashPattern: [4, 4],
        padding: EdgeInsets.zero,
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        color: theme.colors.contrastDark,
        radius: Radius.circular(theme.borderradius.xLarge),
        child: child,
      );

  GestureDetector _buildCrossButton(ThemeData theme) => GestureDetector(
        onTap: widget.onDelete,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(
            top: theme.sizing.width.s3,
            left: theme.sizing.width.s3,
            right: theme.sizing.width.s4,
            bottom: theme.sizing.width.s3,
          ),
          child: Icon(
            MinyIcons.cross,
            size: theme.sizing.width.s4,
            color: theme.colors.contrastDark,
          ),
        ),
      );
}
