import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/buttons/pay_using_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../store/models/model_payusing.dart';
import '../../../store/models/model_upi_data.dart';

///
/// Output:
/// UPISchema
/// Amount
/// Message
/// TagList

List<PayUsingModel> getPayUsing() {
  final listOfPayUsing = <PayUsingModel>[
    PayUsingModel('imageUrl', 'PhonePe', 'upiPrefix'),
    PayUsingModel('imageUrl', 'Paytm', 'upiPrefix'),
    PayUsingModel('imageUrl', 'Amazon Pay', 'upiPrefix'),
    PayUsingModel('imageUrl', 'Google Pay', 'upiPrefix'),
  ];
  return listOfPayUsing;
}

// TODO: UPI URL
String getUPIUrl({
  required PayUsingModel selectedPayusingModel,
}) =>
    'upi://';

UpiDataModel getUpiData() {
  final upiDataModel = UpiDataModel(
    payeeFirstName: 'Maa',
    payeeLastName: 'Tarini Center',
    payeeUpiId: 'maatarinicenter1332@ybl',
  );
  return upiDataModel;
}

Future<void> saveData({
  required String amount,
  required String message,
  required List<String> tags,
}) async {
  final dateTime = DateTime.now();
  // Call Store Save Method
  log('AllData : $amount, $message, $tags, $dateTime');
}

Future showScanNPayBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);

  // Getting data from the services
  final listOfPayUsing = getPayUsing();
  final upiDatamodel = getUpiData();

  // Initialisation of local Data
  final tagList = <String>[];
  const _amount = '';
  const _message = '';
  final _selectedPayusingModel = listOfPayUsing[0];

  final upiUrl = getUPIUrl(selectedPayusingModel: _selectedPayusingModel);

  await showScaffoldBottomsheet(
    context,
    children: [
      _buildScanPayNowBody(
        theme: theme,
        tagList: tagList,
        upiDataModel: upiDatamodel,
      ),
      _buildPayNowButtonBody(
        listOfPayUsing,
        upiUrl,
        _amount,
        _message,
        tagList,
      ),
    ],
  );
}

Row _buildPayNowButtonBody(
  List<PayUsingModel> listOfPayUsing,
  String upiUrl,
  String _amount,
  String _message,
  List<String> tagList,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: PayUsingButton(listOfPayUsing: listOfPayUsing),
        ),
        ActionButton(
          title: 'Pay Now',
          onTap: () {
            log('UPIURL: $upiUrl');
            saveData(
              amount: _amount,
              message: _message,
              tags: tagList,
            );
          },
        )
      ],
    );

StatefulBuilder _buildScanPayNowBody({
  required ThemeData theme,
  required List<String> tagList,
  required UpiDataModel upiDataModel,
}) =>
    StatefulBuilder(builder: (context, setState) {
      final scrollController = ScrollController();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      return Expanded(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(height: theme.sizing.height.s5),
              UPICard(
                payeeFirstName: upiDataModel.payeeFirstName,
                payeeLastName: upiDataModel.payeeLastName,
                payeeUpiId: upiDataModel.payeeUpiId,
              ),
              SizedBox(height: theme.sizing.height.s6),
              const UpiInfoCard(),
              SizedBox(height: theme.sizing.height.s6),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: theme.spacing.width.s12,
                  runSpacing: theme.spacing.width.s12,
                  children: [
                    ...tagList.map(
                      (e) => TagCard(
                        tagType: TagType.info,
                        text: e,
                        onDelete: () {
                          setState(() {
                            tagList.remove(e);
                          });
                        },
                      ),
                    ),
                    TagCard(
                      tagType: TagType.create,
                      onTextSubmit: (value) {
                        setState(() {
                          tagList.add(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      );
    });
