import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/buttons/pay_using_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';

Future showScanNPayBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    children: [
      _buildScanPayNowBody(theme),
      _buildPayNowButtonBody(),
    ],
  );
}

Row _buildPayNowButtonBody() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: PayUsingButton(listOfPayUsing: listOfPayUsing),
        ),
        const ActionButton(
          title: 'Pay Now',
        )
      ],
    );

StatefulBuilder _buildScanPayNowBody(ThemeData theme) {
  final tagList = <String>['Groc', 'Home2'];
  return StatefulBuilder(builder: (context, setState) {
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
            const UPICard(
              payeeFirstName: 'Maa',
              payeeLastName: 'Tarini Center',
              payeeUpiId: 'maatarinicenter1332@ybl',
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
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  });
}

List<PayUsingModel> listOfPayUsing = [
  PayUsingModel('imageUrl', 'providerName', 'upiPrefix'),
  PayUsingModel('imageUrl', 'providerName', 'upiPrefix'),
  PayUsingModel('imageUrl', 'providerName', 'upiPrefix'),
  PayUsingModel('imageUrl', 'providerName', 'upiPrefix'),
];
