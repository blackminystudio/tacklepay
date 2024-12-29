import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/buttons/pay_using_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../store/models/model_payusing.dart';
import '../../../store/scanpay_store.dart';

Future showScanNPayBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  final store = Provider.of<ScanpayStore>(context, listen: false)..clearData();

  // Getting data from the services
  final listOfPayUsing = store.getPayUsing();

  await showScaffoldBottomsheet(
    context,
    children: [
      _buildScanPayNowBody(
        theme: theme,
        store: store,
      ),
      _buildPayNowButtonBody(
        listOfPayUsing,
        store,
      ),
    ],
  );
}

Row _buildPayNowButtonBody(
  List<PayUsingModel> listOfPayUsing,
  ScanpayStore store,
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
            store.logAll();
          },
        )
      ],
    );

StatefulBuilder _buildScanPayNowBody({
  required ThemeData theme,
  required ScanpayStore store,
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
      final upiDataModel = store.getUpiData();
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
              UpiInfoCard(
                onAmountChanged: store.setAmount,
                onMessageChanged: store.setMessage,
              ),
              SizedBox(height: theme.sizing.height.s6),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: theme.spacing.width.s12,
                  runSpacing: theme.spacing.width.s12,
                  children: [
                    ...store.tagList.map(
                      (e) => TagCard(
                        tagType: TagType.info,
                        text: e,
                        onDelete: () {
                          setState(() {
                            store.deleteTag(e);
                          });
                        },
                      ),
                    ),
                    TagCard(
                      tagType: TagType.create,
                      onTextSubmit: (value) {
                        setState(() {
                          store.addTag(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      );
    });
