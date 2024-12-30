import 'package:flutter/material.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/profile_page.dart';

Future showProfileBottomsheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    child: ProfilePage(theme: theme),
  );
}
