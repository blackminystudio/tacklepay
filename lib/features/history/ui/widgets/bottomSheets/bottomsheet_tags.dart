import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/tag_tiles.dart';

Future showTagsBottomSheet(BuildContext context) async {
  getTagModel(allTags);
  final theme = Theme.of(context);
  final tagList = getTagModel(allTags);
  const allSelected = true;
  await showScaffoldBottomsheet(context,
      title: 'All Tags',
      actionButton: const Icon(MinyIcons.plus),
      child: Column(
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

          _buildSearchBar(theme),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.width.s12,
            ),
            child: TagTile(
              tagName: 'All',
              isSelected: allSelected,
              onSelection: (value) {
                toggleTagList(value, tagList);
              },
            ),
          ),
          _buildTagTiles(theme, tagList),
          Align(
            alignment: Alignment.bottomCenter,
            child:
                ActionButton(title: 'Apply', padding: theme.spacing.width.s64),
          )
        ],
      ));
}

void toggleTagList(bool value, List<TagModel> tagList) {
  for (var e in tagList) {
    e.isSelected = value;
  }
}

List<String> allTags = [
  'Asset',
  'Birthday',
  'Food',
  'Groceries',
  'Games',
  'Rent',
];
List<TagModel> getTagModel(List<String> tagList) =>
    tagList.map(TagModel.fromList).toList();

class TagModel {
  String tagName;
  bool isSelected;

  TagModel({
    required this.tagName,
    this.isSelected = true,
  });

  static TagModel fromList(String name) => TagModel(tagName: name);

  String getInitial() => tagName[0].toUpperCase();

  void logValue() {
    log('Name: $tagName, Value: $isSelected');
  }
}

Map<String, List<TagModel>> groupTagsByInitial(List<TagModel> tags) =>
    tags.fold<Map<String, List<TagModel>>>({}, (map, tag) {
      final initial = tag.getInitial();
      map.putIfAbsent(initial, () => []);
      map[initial]!.add(tag);
      return map;
    });

Widget _buildTagTiles(ThemeData theme, List<TagModel> tagList) {
  final groupedTags = groupTagsByInitial(tagList);

  return Expanded(
    child: ListView(
      children: groupedTags.entries.map(
        (e) {
          final groupTitle = e.key;
          final tags = e.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: theme.spacing.height.s16),
                child: Container(
                  width: double.infinity,
                  color: theme.colors.contrastLight,
                  padding: EdgeInsets.symmetric(
                    vertical: theme.spacing.height.s8,
                    horizontal: theme.spacing.width.s12,
                  ),
                  child: Text(
                    groupTitle,
                    style: theme.textStyle.bodyBold.copyWith(
                      color: theme.colors.contrastMedium,
                    ),
                  ),
                ),
              ),
              ...tags
                  .map(
                    (tag) => Padding(
                      padding: EdgeInsets.only(
                        top: theme.spacing.height.s16,
                        left: theme.spacing.width.s12,
                        right: theme.spacing.width.s12,
                      ),
                      child: TagTile(
                        tagName: tag.tagName,
                        isSelected: tag.isSelected,
                        onSelection: (value) => tag.isSelected = value,
                        onSaveTag: (value) => tag.tagName = value,
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        },
      ).toList(),
    ),
  );
}

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
