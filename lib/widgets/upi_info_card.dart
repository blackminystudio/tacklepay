import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/theme/theme.dart';
import 'string_constants.dart';

class UpiInfoCard extends StatefulWidget {
  const UpiInfoCard({super.key});

  @override
  State<UpiInfoCard> createState() => _UpiInfoCardState();
}

class _UpiInfoCardState extends State<UpiInfoCard> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  bool _isEditingMessage = false;

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    _amountFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.contrastLight,
          borderRadius: BorderRadius.circular(theme.borderradius.medium),
          border: Border.all(
            color: theme.colors.contrastLow,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: theme.sizing.width.s4,
              vertical: theme.sizing.width.s3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAmount,
                    style: theme.textStyle.bodyBold.copyWith(
                      color: theme.colors.contrastMedium,
                    ),
                  ),
                  SizedBox(
                    width: theme.sizing.width.s32,
                    child: TextField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: hintTextAmount,
                        prefixText: '₹ ',
                        prefixStyle: theme.textStyle.titleBold.copyWith(
                          color: theme.colors.contrastDark,
                        ),
                        border: InputBorder.none,
                        hintStyle: theme.textStyle.bodyBold.copyWith(
                          color: theme.colors.contrastLow,
                        ),
                      ),
                      style: theme.textStyle.titleBold.copyWith(
                        color: theme.colors.contrastDark,
                      ),
                      textAlign: TextAlign.right,
                      onSubmitted: (_) => _messageFocusNode.requestFocus(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.sizing.height.s2),
              Container(
                height: theme.spacing.height.s1,
                color: theme.colors.contrastLow,
              ),
              SizedBox(height: theme.sizing.height.s3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textMessage,
                    style: theme.textStyle.bodyBold.copyWith(
                      color: theme.colors.contrastMedium,
                    ),
                  ),
                  SizedBox(width: theme.sizing.height.s2),
                  Expanded(
                    child: _isEditingMessage
                        ? TextField(
                            controller: _messageController,
                            focusNode: _messageFocusNode,
                            onSubmitted: (_) {
                              setState(() {
                                _isEditingMessage = false;
                              });
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: hintTextMessage,
                              hintStyle: theme.textStyle.bodyBold.copyWith(
                                color: theme.colors.contrastLow,
                              ),
                            ),
                            style: theme.textStyle.headingSmallMedium.copyWith(
                              color: theme.colors.contrastMedium,
                            ),
                            textAlign: TextAlign.right,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEditingMessage = true;
                                _messageFocusNode.requestFocus();
                              });
                            },
                            child: Text(
                              _messageController.text.isEmpty
                                  ? hintTextMessage
                                  : _messageController.text,
                              style:
                                  theme.textStyle.headingSmallMedium.copyWith(
                                color: _messageController.text.isEmpty
                                    ? theme.colors.contrastLow
                                    : theme.colors.contrastMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
