import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/model_payusing.dart';
import 'models/model_upi_data.dart';

//TODO:  NO NEED OF STORE as of now
class ScanpayStore extends ChangeNotifier {
  String amount = '';
  String message = '';
  List<String> tagList = [];

  void setAmount(String value) {
    amount = value;
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
    notifyListeners();
  }

  void addTag(String value) {
    tagList.add(value);
    notifyListeners();
  }

  void deleteTag(String value) {
    tagList.remove(value);
    notifyListeners();
  }

  void clearData() {
    amount = '';
    message = '';
    tagList = [];
    notifyListeners();
  }

//  Other Helper Methods
  void logAll() {
    log('message: $message, amount: $amount, tags: $tagList');
  }

  String getUPIUrl({
    required PayUsingModel selectedPayusingModel,
  }) =>
      'upi://';
  List<PayUsingModel> getPayUsing() {
    final listOfPayUsing = <PayUsingModel>[
      PayUsingModel('imageUrl', 'PhonePe', 'upiPrefix'),
      PayUsingModel('imageUrl', 'Paytm', 'upiPrefix'),
      PayUsingModel('imageUrl', 'Amazon Pay', 'upiPrefix'),
      PayUsingModel('imageUrl', 'Google Pay', 'upiPrefix'),
    ];
    return listOfPayUsing;
  }

  UpiDataModel getUpiData() {
    final upiDataModel = UpiDataModel(
      payeeFirstName: 'Maa',
      payeeLastName: 'Tarini Center',
      payeeUpiId: 'maatarinicenter1332@ybl',
    );
    return upiDataModel;
  }
}
