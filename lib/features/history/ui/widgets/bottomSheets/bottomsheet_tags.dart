import 'package:flutter/material.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/filters/tag_page.dart';

Future showTagsBottomSheet(BuildContext context) async {
  await showScaffoldBottomsheet(
    context,
    child: const TagPage(),
  );
}
