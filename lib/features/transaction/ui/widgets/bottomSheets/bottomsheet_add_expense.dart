import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';

import '../../../../../widgets/buttons/toggle_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../../../widgets/pay_date_dropdown.dart';

Future showAddExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  var isExpense = false;
  log(isExpense.toString());
  await showScaffoldBottomsheet(
    title: isExpense ? 'Expense' : 'Income',
    context,
    actionButton: _buildMinyToggleButton(
      isExpense: isExpense,
      onChanged: (value) {
        isExpense = value;
        // log(isExpense.toString());
      },
    ),
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
          child: PayDateDropdown(),
        ),
        const ActionButton(
          title: 'Add Expense',
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

MinyToggleButton _buildMinyToggleButton({
  required bool isExpense,
  required Function(bool value) onChanged,
}) =>
    MinyToggleButton(
      value: isExpense,
      onChanged: (value) => onChanged.call(value),
    );
