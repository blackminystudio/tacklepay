import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';

Future showProfileBottomsheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    title: 'Profile',
    children: [
      SizedBox(height: theme.sizing.height.s22),
      Center(
        child: Container(
          height: theme.sizing.width.s32,
          width: theme.sizing.width.s32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    'https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg')),
          ),
        ),
      ),
      SizedBox(height: theme.sizing.width.s7),
      Center(
        child: Text(
          'Satyabrata Nayak',
          style: theme.textStyle.titleRegular.copyWith(
            color: theme.colors.contrastDark,
          ),
        ),
      ),
      SizedBox(height: theme.sizing.width.s3),
      Center(
        child: Text(
          'satyabratanayakofficial@gmail.com',
          style: theme.textStyle.bodyRegular.copyWith(
            color: theme.colors.contrastMedium,
          ),
        ),
      ),
      const Spacer(),
      Center(
          child:
              ActionButton(title: 'Log out', padding: theme.sizing.width.s12)),
    ],
  );
}
