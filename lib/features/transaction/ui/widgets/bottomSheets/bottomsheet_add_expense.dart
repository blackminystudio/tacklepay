import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';

import '../../../../../widgets/buttons/toggle_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../../../widgets/pay_date_dropdown.dart';
import '../../../store/transaction_store.dart';

Future showAddExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  final store = Provider.of<TransactionStore>(context, listen: false);

  await showScaffoldBottomsheet(
    context,
    actionButton: _buildMinyToggleButton(
      isExpense: store.isExpense,
      onChanged: (value) {
        store.setIsExpense(value);
      },
    ),
    children: [
      _buildScanPayNowBody(theme, store),
      StatefulBuilder(
        builder: (context, _) => _buildPayNowButtonBody(context),
      ),
    ],
  );
}

Row _buildPayNowButtonBody(BuildContext context) {
  final store = Provider.of<TransactionStore>(context);
  final theme = Theme.of(context);
  log('valuse:${store.isExpense}');
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
        child: PayDateDropdown(),
      ),
      ActionButton(
        color: !store.isExpense ? theme.colors.primary : null,
        title: store.isExpense ? 'Add Expense' : 'Add Income',
      )
    ],
  );
}

StatefulBuilder _buildScanPayNowBody(ThemeData theme, TransactionStore store) {
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
            SizedBox(height: theme.sizing.height.s13),
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
                          store.tagList.remove(e);
                          // notifyListeners
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
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  });
}

MinyToggleButton _buildMinyToggleButton({
  required bool isExpense,
  required Function(bool value) onChanged,
}) =>
    MinyToggleButton(
      value: isExpense,
      onChanged: (value) => onChanged.call(value),
    );
