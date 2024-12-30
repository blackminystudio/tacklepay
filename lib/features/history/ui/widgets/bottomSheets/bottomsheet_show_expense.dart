import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';

import '../../../../../widgets/cards/tag_card.dart';

import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../../../widgets/pay_date_dropdown.dart';

Future showExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    children: [
      _buildScanPayNowBody(theme),
      _buildPayNowButtonBody(),
    ],
  );
}

Expanded _buildPayNowButtonBody() => Expanded(
      child: PayDateDropdown(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
