import 'package:intl/intl.dart';

import '../../../../widgets/string_constants.dart';

class Format {
  static bool _isIntegerLimited(String text) =>
      text.length > 6 ||
      BigInt.tryParse(text) != null && BigInt.parse(text) > BigInt.from(999999);

  static String _validateMaxAmountAndDecimalLimit(String text) {
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

  static String _addCommasToInteger(String text) {
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

  static String _formatIndianNumber(String number) {
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

  static String _ensureRupeeSymbol(String text) {
    if (text.isNotEmpty && !text.startsWith(rupeeSymbol)) {
      text = '$rupeeSymbol$text';
    }
    return text;
  }

  static String amount(int? val) {
    if (val == null) return '';
    var amount = val.toString().trim();
    amount = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    amount = _validateMaxAmountAndDecimalLimit(amount);
    amount = _addCommasToInteger(amount);
    amount = _ensureRupeeSymbol(amount);
    return amount;
  }

  static String tags(String val) {
    val = val.trim();
    return val.toLowerCase();
  }

  static String? date(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String? time(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String? dateAsString(String? dateTime) {
    if (dateTime == null) return null;
    final date = DateTime.parse(dateTime);
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
