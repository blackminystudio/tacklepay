import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/buttons/action_button.dart';

import '../../../../../widgets/buttons/toggle_button.dart';
import '../../../../../widgets/cards/tag_card.dart';
import '../../../../../widgets/cards/upi_info_card.dart';
import '../../../../../widgets/pay_date_dropdown.dart';
import '../../../../widgets/string_constants.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  bool isExpense = true;
  String? amount;
  String? message;
  String? errorMessage;
  DateTime dateTime = DateTime.now();
  final tagList = <String>[];
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void setIsExpense(bool val) {
    setState(() {
      isExpense = val;
    });
  }

  void setAmount(String val) {
    setState(() {
      amount = val;
    });
  }

  void setMessage(String val) {
    setState(() {
      message = val;
    });
  }

  void setDate(DateTime val) {
    setState(() {
      dateTime = val;
    });
  }

  void addTag(String value) {
    setState(() {
      tagList.add(value);
    });
  }

  void deleteTag(String val) {
    setState(() {
      tagList.remove(val);
    });
  }

  void onAddExpense() {
    final messageIsNotEmpty = message?.isNotEmpty ?? false;
    final amountIsNotEmpty = amount?.isNotEmpty ?? false;
    if (amountIsNotEmpty && messageIsNotEmpty) {
      log('$isExpense');
      log('$tagList');
      log('$amount');
      log('$message');
      log('$dateTime');
      setState(() {
        errorMessage = null;
      });
    } else {
      log('message');
      setState(() {
        errorMessage = !amountIsNotEmpty
            ? 'Amount can\'t be empty'
            : 'Message can\'t be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: widget.theme.colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(MinyIcons.navArrowLeft),
                      SizedBox(width: widget.theme.sizing.width.s4),
                      Text(
                        isExpense ? expenseText : incomeText,
                        style: widget.theme.textStyle.titleRegular,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              _buildMinyToggleButton(
                isExpense: isExpense,
                onChanged: setIsExpense,
              ),
            ],
          ),
          _buildAddTransactionBody(widget.theme),
          _buildPayNowButtonBody(context),
        ],
      );

  Row _buildPayNowButtonBody(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: PayDateDropdown(
            onChangedDate: setDate,
          ),
        ),
        ActionButton(
          color: isExpense ? null : theme.colors.primary,
          title: isExpense ? addExpenseText : addIncomeText,
          onTap: onAddExpense,
        )
      ],
    );
  }

  Widget _buildAddTransactionBody(ThemeData theme) => Expanded(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(height: theme.sizing.height.s13),
              UpiInfoCard(
                onAmountChanged: setAmount,
                onMessageChanged: setMessage,
              ),
              if (errorMessage != null)
                SizedBox(height: theme.sizing.height.s3),
              if (errorMessage != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorMessage!,
                    style: theme.textStyle.bodyRegular.copyWith(
                      color: theme.colors.secondaryDark,
                    ),
                  ),
                ),
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
                          onDelete: () => deleteTag(e)),
                    ),
                    TagCard(
                      tagType: TagType.create,
                      onTextSubmit: addTag,
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

  MinyToggleButton _buildMinyToggleButton({
    required bool isExpense,
    required Function(bool value) onChanged,
  }) =>
      MinyToggleButton(
        value: isExpense,
        onChanged: (value) => onChanged.call(value),
      );
}
