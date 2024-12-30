import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/filters/tag_page.dart';

Future showTagsBottomSheet(BuildContext context) async {
  getTagModel(allTags);
  final theme = Theme.of(context);
  final tagList = getTagModel(allTags);
  const allSelected = true;
  await showScaffoldBottomsheet(
    context,
    title: 'All Tags',
    actionButton: const Icon(MinyIcons.plus),
    child: TagPage(
      theme: theme,
      allSelected: allSelected,
      tagList: tagList,
    ),
  );
}
