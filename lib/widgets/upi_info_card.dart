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
  String _originalText = '';

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    _amountFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _messageFocusNode.addListener(
      () {
        if (_messageFocusNode.hasFocus) {
          onTapMessageField();
        } else {
          onSubmitMessageField(_originalText);
        }
      },
    );
  }

  void onSubmitAmount(String value) {
    if (value == rupeeSymbol ||
        value.trim() == rupeeSymbol ||
        value.trim() == '$rupeeSymbol.' ||
        value.trim() == '${rupeeSymbol}0' ||
        value.trim() == '${rupeeSymbol}0.' ||
        value.trim() == '${rupeeSymbol}0.0' ||
        value.trim() == '${rupeeSymbol}0.00') {
      _amountController.clear();
    } else {
      _messageFocusNode.requestFocus();
    }
  }

  void onSubmitMessageField(String text) {
    // Update the original
    _originalText = text;
    if (text.length > 15) {
      _messageController
        ..text = '${text.substring(0, 15)}...'
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: _messageController.text.length),
        );
    }
  }

  void onTapMessageField() {
    // Restore the original text
    _messageController
      ..text = _originalText
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.contrastLight,
          borderRadius: BorderRadius.circular(
            theme.borderradius.medium,
          ),
          border: Border.all(
            color: theme.colors.contrastLow,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.sizing.width.s4,
            vertical: theme.sizing.width.s3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTitle(amountText, theme),
                  Expanded(
                    child: buildAmountField(theme),
                  ),
                ],
              ),
              Container(
                height: theme.spacing.height.s1,
                color: theme.colors.contrastLow,
                margin: EdgeInsets.symmetric(
                  vertical: theme.sizing.height.s3,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitle(messageText, theme),
                  Expanded(
                    child: buildMessageField(theme),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTitle(String title, ThemeData theme) => Padding(
        padding: EdgeInsets.only(right: theme.sizing.height.s2),
        child: Text(
          title,
          style: theme.textStyle.bodyBold.copyWith(
            color: theme.colors.contrastMedium,
          ),
        ),
      );

  TextField buildMessageField(ThemeData theme) => TextField(
        controller: _messageController,
        focusNode: _messageFocusNode,
        onSubmitted: onSubmitMessageField,
        decoration: inputDecoration(theme, hintTextMessage),
        onTap: onTapMessageField,
        style: theme.textStyle.headingSmallMedium.copyWith(
          color: theme.colors.contrastMedium,
        ),
        textAlign: TextAlign.right,
      );

  TextField buildAmountField(ThemeData theme) => TextField(
        enableInteractiveSelection: false,
        controller: _amountController,
        focusNode: _amountFocusNode,
        textAlign: TextAlign.right,
        onSubmitted: onSubmitAmount,
        inputFormatters: [AmountInputFormatter()],
        decoration: inputDecoration(theme, hintTextAmount),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        style: theme.textStyle.titleBold.copyWith(
          color: theme.colors.contrastDark,
        ),
      );

  InputDecoration inputDecoration(ThemeData theme, String hintText) =>
      InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: theme.textStyle.bodyBold.copyWith(
          color: theme.colors.contrastLow,
        ),
      );
}

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    text = _extractNumericText(text);
    text = _validateMaxAmountAndDecimalLimit(text);
    text = _replaceZeroToDecimal(text);
    text = _addCommasToInteger(text);
    text = _ensureRupeeSymbol(text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String _extractNumericText(String text) =>
      text.replaceAll(RegExp(r'[^0-9.]'), '');

  String _validateMaxAmountAndDecimalLimit(String text) {
    // Split the number into integer and decimal parts
    if (text.contains('.')) {
      final parts = text.split('.');
      var integerPart = parts[0];
      var decimalPart = parts.length > 1 ? parts[1] : '';
      // Ensure 999999
      if (_isIntegerLimited(integerPart)) {
        integerPart = integerPart.substring(0, 6);
      }
      // Ensure .99
      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }
      return '$integerPart.$decimalPart';
    }
    // Ensure 999999
    if (_isIntegerLimited(text)) return text.substring(0, 6);
    return text;
  }

  bool _isIntegerLimited(String text) =>
      text.length > 6 ||
      BigInt.tryParse(text) != null && BigInt.parse(text) > BigInt.from(999999);

  String _replaceZeroToDecimal(String text) {
    if (text.startsWith('0') && text.length > 1 && !text.contains('.')) {
      text = text.replaceFirst('0', '0.');
    }
    if (text.startsWith('.') && text.length > 1) {
      text = text.replaceFirst('.', '0.');
    }

    return text;
  }

  String _addCommasToInteger(String text) {
    if (text.contains('.')) {
      final parts = text.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? parts[1] : '';
      final formattedInteger = _formatIndianNumber(integerPart);
      final formattedText =
          '$formattedInteger${decimalPart.isNotEmpty ? '.$decimalPart' : '.'}';
      return formattedText;
    }
    return _formatIndianNumber(text);
  }

  String _formatIndianNumber(String number) {
    if (number.isEmpty) return number;
    final length = number.length;
    if (length <= 3) return number;

    final lastThree = number.substring(length - 3);
    final remaining = number.substring(0, length - 3);

    // Format the remaining part with commas
    final regExp = RegExp(r'(\d)(?=(\d{2})+(?!\d))');
    final formattedRemaining = remaining.replaceAllMapped(
      regExp,
      (Match match) => '${match[1]},',
    );
    return '$formattedRemaining,$lastThree';
  }

  String _ensureRupeeSymbol(String text) {
    if (text.isNotEmpty && !text.startsWith(rupeeSymbol)) {
      text = '$rupeeSymbol$text';
    }
    return text;
  }
}
