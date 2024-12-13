import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class WelcomeCard extends StatelessWidget {
  final String greetingMessage;
  final String userName;
  final String profilePictureUrl;

  const WelcomeCard({
    super.key,
    required this.greetingMessage,
    required this.userName,
    required this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: theme.borderradius.full(theme.sizing.width.s15),
          backgroundImage: NetworkImage(profilePictureUrl),
        ),
        SizedBox(width: theme.sizing.width.s4),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingMessage,
                style: theme.textStyle.bodyRegular.copyWith(
                  color: theme.colors.contrastMedium,
                ),
              ),
              Text(
                userName,
                style: theme.textStyle.headingLargeBold.copyWith(
                  color: theme.colors.contrastDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
