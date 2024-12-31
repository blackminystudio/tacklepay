import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/tag_tiles.dart';
import '../../../store/models/tag_models.dart';

// Create new tags
// Edit tags + Scroll to up

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<TagGroup> groupedTags = [];
  bool allSelected = true;

  @override
  void initState() {
    super.initState();
    loadTags();
  }

  void loadTags() {
    // Call from Database
    final tags = dummyJson.map(Tag.fromJson).toList();
    groupedTags = groupTagsAlphabetically(tags);
  }

  // DELETE
  void deleteTag(String groupName, String tagId) {
    setState(() {
      // Find the group and remove the tag
      final group = groupedTags.firstWhere((g) => g.groupName == groupName);
      group.tags.removeWhere((tag) => tag.id == tagId);

      // Remove the group if it is empty
      if (group.tags.isEmpty) {
        groupedTags.remove(group);
      }
    });
  }

  void logGroup() {
    for (final element in groupedTags) {
      for (final tag in element.tags) {
        log('${tag.name}, selected: ${tag.isSelected}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(context, theme),
        _buildSearchBar(theme),
        _buildAllSelect(theme),
        _buildTagTilesBody(theme),
        _buildActionButton(theme)
      ],
    );
  }

  Align _buildActionButton(ThemeData theme) => Align(
        alignment: Alignment.bottomCenter,
        child: ActionButton(title: 'Apply', padding: theme.spacing.width.s64),
      );

  Widget _buildAllSelect(ThemeData theme) => groupedTags.isNotEmpty
      ? Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.width.s12,
          ),
          child: TagTile(
            tagName: 'All',
            isSelected: allSelected,
            onSelection: (val) {
              setState(() {
                allSelected = val;
                for (final group in groupedTags) {
                  for (final tag in group.tags) {
                    tag.isSelected = val;
                  }
                }
              });
            },
          ),
        )
      : const SizedBox.shrink();

  Row _buildHeaderSection(BuildContext context, ThemeData theme) => Row(
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Merge',
              style: theme.textStyle.bodyRegular.copyWith(
                color: theme.colors.contrastDark,
              ),
            ),
          ),
        ],
      );

  Widget _buildTagTilesBody(ThemeData theme) => groupedTags.isEmpty
      ? const Expanded(child: Center(child: Text('No Tags Available')))
      : Expanded(
          child: ListView.builder(
            itemCount: groupedTags.length,
            itemBuilder: (context, index) {
              final group = groupedTags[index];
              // Tag Grouping
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTagGroupHeader(theme, group),
                  ...group.tags
                      .map(
                        (tag) => _buildTagTile(tag, group, theme),
                      )
                      .toList(),
                ],
              );
            },
          ),
        );

  Dismissible _buildTagTile(Tag tag, TagGroup group, ThemeData theme) =>
      Dismissible(
        key: Key(tag.id),
        onDismissed: (direction) {
          deleteTag(group.groupName, tag.id);
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: theme.spacing.height.s16,
            left: theme.spacing.width.s12,
            right: theme.spacing.width.s12,
          ),
          child: TagTile(
            tagName: tag.name,
            isSelected: tag.isSelected,
            onSelection: (value) {
              setState(() {
                tag.isSelected = value;
              });
            },
            onSaveTag: (value) {
              setState(() {
                tag.name = value;
              });
            },
          ),
        ),
      );

  Padding _buildTagGroupHeader(ThemeData theme, TagGroup group) => Padding(
        padding: EdgeInsets.only(top: theme.spacing.height.s16),
        child: Container(
          width: double.infinity,
          color: theme.colors.contrastLight,
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.height.s8,
            horizontal: theme.spacing.width.s12,
          ),
          child: Text(
            group.groupName,
            style: theme.textStyle.bodyBold.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ),
      );

  Widget _buildSearchBar(ThemeData theme) => Padding(
        padding: EdgeInsets.symmetric(vertical: theme.sizing.width.s10),
        child: Container(
          height: theme.sizing.height.s12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.borderradius.small),
            color: theme.colors.contrastLight,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.width.s10),
            child: Row(
              children: [
                Icon(
                  MinyIcons.search,
                  color: theme.colors.contrastMedium,
                ),
                SizedBox(width: theme.sizing.width.s3),
                Text(
                  'Search Tags',
                  style: theme.textStyle.bodyRegular.copyWith(
                    color: theme.colors.contrastMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
