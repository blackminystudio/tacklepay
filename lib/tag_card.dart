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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.tagType == TagType.create && isEditing) {
      return DottedBorder(
        dashPattern: [4, 4],
        strokeCap: StrokeCap.round,
        strokeWidth: 2,
        padding: EdgeInsets.zero,
        color: theme.colors.contrastDark,
        borderType: BorderType.RRect,
        radius: Radius.circular(theme.borderradius.xLarge),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.sizing.width.s5,
          ),
          decoration: BoxDecoration(
            color: theme.colors.contrastLow,
            borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
          ),
          width: theme.sizing.width.s28,
          height: theme.sizing.height.s11,
          child: Center(
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: theme.textStyle.bodyBold.copyWith(
                color: theme.colors.contrastDark,
              ),
              decoration: InputDecoration(
                hintStyle: theme.textStyle.bodyBold.copyWith(
                  color: theme.colors.contrastDark,
                ),
                isCollapsed: true,
                hintText: enterTagText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: theme.sizing.width.s2,
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onTextSubmit?.call(value);
                  setState(() {
                    isEditing = false;
                  });
                  _controller.clear();
                }
              },
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
          ? DottedBorder(
              dashPattern: [4, 4],
              strokeCap: StrokeCap.round,
              strokeWidth: 2,
              color: theme.colors.contrastDark,
              borderType: BorderType.RRect,
              radius: Radius.circular(theme.borderradius.xLarge),
              padding: EdgeInsets.zero,
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
                    createText,
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
                  if (widget.tagType == TagType.info) buildCrossButton(theme),
                ],
              ),
            ),
    );
  }

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
