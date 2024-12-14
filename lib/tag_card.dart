import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'widgets/string_constants.dart';

enum TagType {
  info,
  create,
}

class TagCard extends StatefulWidget {
  final TagType tagType;
  final String? text;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final ValueChanged<String>? onTextSubmit;

  const TagCard({
    super.key,
    required this.tagType,
    this.text,
    this.onTap,
    this.onDelete,
    this.onTextSubmit,
  });

  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  bool isEditing = false;
  final TextEditingController _controller = TextEditingController();

  void onSubmitted(String value) {
    if (value.isNotEmpty) {
      widget.onTextSubmit?.call(value);
    }
    clearField();
  }

  void clearField() {
    setState(() {
      isEditing = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.tagType == TagType.create && isEditing) {
      return buildDottedBorderWrapper(
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
              onSubmitted: onSubmitted,
              onTapOutside: (_) => clearField(),
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
      onTap: widget.tagType == TagType.create ? () => setState(() => isEditing = true) : widget.onTap,
      child: widget.tagType == TagType.create
          ? buildDottedBorderWrapper(
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
                        left: theme.sizing.width.s4,
                        top: theme.sizing.width.s3,
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
                  buildCrossButton(theme),
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

  DottedBorder buildDottedBorderWrapper({
    required ThemeData theme,
    required Widget child,
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

  GestureDetector buildCrossButton(ThemeData theme) => GestureDetector(
        onTap: widget.onDelete,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(
            left: theme.sizing.width.s3,
            top: theme.sizing.width.s3,
            right: theme.sizing.width.s4,
            bottom: theme.sizing.width.s3,
          ),
          child: Icon(
            MinyIcons.cross,
            color: theme.colors.contrastDark,
            size: theme.sizing.width.s4,
          ),
        ),
      );
}
