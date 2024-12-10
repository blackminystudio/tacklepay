import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'theme/theme.dart';
import 'widgets/string_constants.dart';

class PayUsingModel {
  final String imageUrl;
  final String providerName;
  final String upiPrefix;
  PayUsingModel(
    this.imageUrl,
    this.providerName,
    this.upiPrefix,
  );
}

class PayUsingButton extends StatefulWidget {
  final List<PayUsingModel> listOfPayUsing;
  const PayUsingButton({
    super.key,
    required this.listOfPayUsing,
  });

  @override
  State<PayUsingButton> createState() => _PayUsingButtonState();
}

class _PayUsingButtonState extends State<PayUsingButton> {
  bool isExpanded = false;
  final ScrollController _scrollController = ScrollController();
  late PayUsingModel selectedModel;

  @override
  void initState() {
    selectedModel = widget.listOfPayUsing.first;
    super.initState();
  }

  void toggleDropdown() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void selectOption(PayUsingModel model) {
    setState(() {
      selectedModel = model;
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listOfPayUsing = widget.listOfPayUsing;
    final cardWidth = theme.sizing.height.s16;

    GestureDetector itemBuilder(BuildContext context, int index) {
      final model = listOfPayUsing
          .where((model) => model != selectedModel)
          .toList()[index];
      return GestureDetector(
        onTap: () => selectOption(model),
        child: buildPaymentOption(model, theme, cardWidth),
      );
    }

    double getHeight() =>
        isExpanded ? cardWidth * (listOfPayUsing.length - 1) : 0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            height: getHeight(),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              itemCount: getItemCount(listOfPayUsing),
              itemBuilder: itemBuilder,
            ),
          ),
          GestureDetector(
            onTap: toggleDropdown,
            child: buildPaymentOption(selectedModel, theme, cardWidth),
          ),
        ],
      ),
    );
  }

  int getItemCount(List<PayUsingModel> listOfPayUsing) =>
      listOfPayUsing.where((model) => model != selectedModel).length;

  Widget buildPaymentOption(
    PayUsingModel model,
    ThemeData theme,
    double cardWidth,
  ) =>
      Container(
        height: cardWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(theme.sizing.width.s10),
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: model.imageUrl,
                width: theme.sizing.width.s10,
                height: theme.sizing.width.s10,
              ),
            ),
            SizedBox(width: theme.spacing.width.s12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      payUsingText,
                      style: theme.textStyle.caption.copyWith(
                        color: theme.colors.contrastMedium,
                      ),
                    ),
                    SizedBox(
                      width: theme.spacing.width.s8,
                    ),
                    if (model == selectedModel)
                      Icon(
                        !isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                        size: theme.spacing.width.s12,
                        color: theme.colors.contrastMedium,
                      )
                  ],
                ),
                Text(
                  model.providerName,
                  style: theme.textStyle.headingSmallMedium.copyWith(
                    color: theme.colors.contrastDark,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
