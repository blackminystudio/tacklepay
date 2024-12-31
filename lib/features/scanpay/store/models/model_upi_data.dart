import 'dart:developer';

class UpiDataModel {
  final String payeeFirstName;
  final String payeeLastName;
  final String payeeUpiId;

  UpiDataModel({
    required this.payeeFirstName,
    required this.payeeLastName,
    required this.payeeUpiId,
  });
  static UpiDataModel? parseUpiString(String upiString) {
    try {
      final uri = Uri.parse(upiString);

      // Extract the UPI parameters
      final payeeName = uri.queryParameters['pn'] ?? '';
      final payeeUpiId = uri.queryParameters['pa'] ?? '';

      // Split the payee's full name into first and last names
      final nameParts = payeeName.split(' ');
      final payeeFirstName = nameParts.isNotEmpty ? nameParts.first : '';
      final payeeLastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      // Create and return the UpiDataModel
      return UpiDataModel(
        payeeFirstName: payeeFirstName,
        payeeLastName: payeeLastName,
        payeeUpiId: payeeUpiId,
      );
    } catch (e) {
      log('Error parsing UPI string: $e');
      return null; // Return null in case of failure
    }
  }
}
