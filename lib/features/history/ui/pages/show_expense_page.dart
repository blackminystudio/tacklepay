import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/cards/tag_card.dart';
import '../../../../widgets/cards/upi_info_card.dart';
import '../../../../widgets/pay_date_dropdown.dart';
import 'history_page.dart';

class ShowExpensePage extends StatelessWidget {
  final TransactionModel transactionModel;
  const ShowExpensePage({
    super.key,
    required this.theme,
    required this.transactionModel,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: theme.colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(MinyIcons.navArrowLeft),
                      SizedBox(width: theme.sizing.width.s4),
                      Text(
                        'Expense',
                        style: theme.textStyle.titleRegular,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          _buildScanPayNowBody(theme),

          PayDateDropdown()
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: theme.sizing.height.s13),
              UpiInfoCard(transactionModel: transactionModel),
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
}
