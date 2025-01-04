import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/tag_tiles.dart';
import '../../../store/models/tag_models.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<Tag> originalTags = []; // Holds all tags, unfiltered
  List<Tag> tagList = [];

  bool allSelected = true;
  final tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTags(dummyJson);
  }

  void _loadTags(List<Map<String, dynamic>> json) {
    tagList = loadTagAlphabetically(json);
  }

  // CREATE
  void _createTag(String? value) {
    if (value == null) return;
    final id = const UuidV4().generate();
    setState(() {
      final tag = Tag(id: id, name: value);
      tagList.add(tag);
    });
  }

  // UPDATE
  void _updateTag(String value, Tag tag) {
    setState(() {
      tag.name = value;
    });
  }

  // MERGE
  void _mergeTag(String? value, List<Tag> selectedTag) {
    if (value == null) return;
    _createTag(value);
    setState(() {
      tagList.removeWhere(selectedTag.contains);
    });
  }

  // DELETE
  void _deleteTag(Tag tag) {
    setState(() {
      tagList.removeWhere((e) => e.id == tag.id);
    });
  }

  // SEARCH

  void onSearch(String value) {
    final originalTags = List<Tag>.from(tagList);
    setState(() {
      if (value.isEmpty) {
        tagList = List.from(originalTags);
      } else {
        tagList = originalTags
            .where(
                (tag) => tag.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  // SELECT TAGS
  void _selectAll(bool val) {
    setState(() {
      allSelected = val;
      for (var tag in tagList) {
        tag.isSelected = val;
      }
    });
  }

  // Other Helper Methods

  void _logTags() {
    log('TAG:==============================');
    for (final tag in tagList) {
      log('Tag: ${tag.name}, Id: ${tag.id}, selected: ${tag.isSelected}');
    }
  }

  int _countSelectedTags() {
    var selectCount = 0;
    for (final tag in tagList) {
      if (tag.isSelected == true) selectCount++;
    }
    return selectCount;
  }

  List<Tag> _selectedTags() =>
      tagList.where((e) => e.isSelected == true).toList();

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
        child: ActionButton(
          title: 'Apply',
          padding: theme.spacing.width.s64,
          onTap: () {
            _logTags();
          },
        ),
      );

  Widget _buildAllSelect(ThemeData theme) => tagList.isNotEmpty
      ? Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.width.s12,
          ),
          child: TagTile(
            tagName: 'All',
            isSelected:
                tagList.length > _countSelectedTags() ? false : allSelected,
            onSelection: _selectAll,
          ),
        )
      : const SizedBox.shrink();

  Row _buildHeaderSection(BuildContext context, ThemeData theme) {
    final canMerge = _countSelectedTags() > 1;
    final selectedTags = _selectedTags();
    return Row(
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
          onTap: () => showDialogeForCreateTag(canMerge, selectedTags),
          child: canMerge
              ? Text(
                  'Merge',
                  style: theme.textStyle.bodyRegular.copyWith(
                    color: theme.colors.contrastDark,
                  ),
                )
              : const Icon(MinyIcons.plus),
        ),
      ],
    );
  }

  void showDialogeForCreateTag(bool canMerge, List<Tag> selectedTag) {
    if (canMerge) {
      tagController.text = selectedTag.first.name;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit Text'),
              content: TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter new text',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(tagController.text),
                  child: const Text('Save'),
                ),
              ],
            )).then(
      (value) {
        tagController.clear();
        canMerge
            ? _mergeTag(value as String?, selectedTag)
            : _createTag(value as String?);
      },
    );
  }

  Widget _buildTagTilesBody(ThemeData theme) {
    final tagGroup = getTagGroupList(tagList);

    return tagGroup.isEmpty
        ? const Expanded(child: Center(child: Text('No Tags Available')))
        : Expanded(
            child: ListView.builder(
              itemCount: tagGroup.length,
              itemBuilder: (context, index) {
                final groupName = tagGroup[index]['groupName'] as String;
                final tagList = tagGroup[index]['tags'] as List<Tag>;

                // Tag Grouping
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTagGroupHeader(theme, groupName),
                    ...tagList.map((tag) => _buildTagTile(tag, theme)).toList(),
                  ],
                );
              },
            ),
          );
  }

  Dismissible _buildTagTile(Tag tag, ThemeData theme) => Dismissible(
        key: Key(tag.id),
        onDismissed: (direction) {
          _deleteTag(tag);
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
            onSaveTag: (value) => _updateTag(value, tag),
          ),
        ),
      );

  Padding _buildTagGroupHeader(ThemeData theme, String groupName) => Padding(
        padding: EdgeInsets.only(top: theme.spacing.height.s16),
        child: Container(
          width: double.infinity,
          color: theme.colors.contrastLight,
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.height.s8,
            horizontal: theme.spacing.width.s12,
          ),
          child: Text(
            groupName,
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
            child: Center(
              child: TextField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    MinyIcons.search,
                    color: theme.colors.contrastMedium,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search Tags',
                  hintStyle: theme.textStyle.bodyRegular.copyWith(
                    color: theme.colors.contrastMedium,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}


// Row(
//               children: [
//                 Icon(
//                   MinyIcons.search,
//                   color: theme.colors.contrastMedium,
//                 ),
//                 SizedBox(width: theme.sizing.width.s3),
//                 Text(
//                   'Search Tags',
//                   style: theme.textStyle.bodyRegular.copyWith(
//                     color: theme.colors.contrastMedium,
//                   ),
//                 ),
//               ],
//             ),