// Tag Model

class Tag {
  String id;
  String name;
  bool isSelected;

  Tag({
    required this.id,
    required this.name,
    this.isSelected = true,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

// TagGroup Model
class TagGroup {
  String groupName;
  List<Tag> tags;

  TagGroup({required this.groupName, required this.tags});

  factory TagGroup.fromJson(Map<String, dynamic> json) => TagGroup(
        groupName: json['groupName'] as String,
        tags: (json['tags'] as List<Map<String, dynamic>>)
            .map(Tag.fromJson)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'tags': tags.map((tag) => tag.toJson()).toList(),
      };
}

// Dummy JSON Data
final List<Map<String, dynamic>> dummyJson = [
  {'id': '1', 'name': 'Asset'},
  {'id': '2', 'name': 'Ask'},
  {'id': '4', 'name': 'Big'},
  {'id': '5', 'name': 'Bowl'},
  {'id': '6', 'name': 'Cat'},
  {'id': '7', 'name': 'Cake'},
  {'id': '3', 'name': 'Basket'},
];

//  Convet list of tag to List<TagGroup>
List<TagGroup> groupTagsAlphabetically(List<Tag> tags) {
  final grouped = <String, List<Tag>>{};

  // Group tags by the first letter of their name
  for (var tag in tags) {
    final groupName = tag.name[0].toUpperCase();
    if (!grouped.containsKey(groupName)) {
      grouped[groupName] = [];
    }
    grouped[groupName]!.add(tag);
  }

  // Sort the tags within each group and the group keys
  final sortedGroups = grouped.entries.map((entry) {
    entry.value.sort((a, b) =>
        a.name.compareTo(b.name)); // Sort tags alphabetically within each group
    return MapEntry(entry.key, entry.value);
  }).toList()
    ..sort((a, b) =>
        a.key.compareTo(b.key)); // Sort groups alphabetically by group name

  // Convert to List<TagGroup>
  return sortedGroups
      .map((entry) => TagGroup(groupName: entry.key, tags: entry.value))
      .toList();
}

List<Tag> loadTagAlphabetically(List<Map<String, dynamic>> tagsData) {
  final orderedTagsData = List<Map<String, dynamic>>.from(tagsData)
    ..sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
  final list = orderedTagsData.map(Tag.fromJson).toList();
  return list;
}

List<Map<String, dynamic>> getTagGroupList(List<Tag> tags) {
  tags.sort((a, b) => a.name.compareTo(b.name));
  // Group tags by the first letter of their name
  final groupedTags = <String, List<Tag>>{};

  // Iterate over each tag and group by the initial letter
  for (var tag in tags) {
    final initial =
        tag.name[0].toUpperCase(); // Get the first letter and capitalize
    if (!groupedTags.containsKey(initial)) {
      groupedTags[initial] = [];
    }
    groupedTags[initial]!.add(tag);
  }

  // Convert the groupedTags into a List of Maps with 'groupName' and 'tags'
  final List<Map<String, dynamic>> result = groupedTags.entries
      .map((entry) => {
            'groupName': entry.key,
            'tags': entry.value,
          })
      .toList()
    ..sort((a, b) =>
        (a['groupName'] as String).compareTo(b['groupName'] as String));

  return result;
}

// Example usage
void main() {
  final tags = loadTagAlphabetically(dummyJson);

  final groupedTagList = getTagGroupList(tags);

  // Printing the result
  for (var group in groupedTagList) {
    print('${group['groupName']}: ${group['tags']}');
  }
}

List<Map<String, dynamic>> convertGroupToJson(List<TagGroup> tagGroups) {
  final jsonList = <Map<String, dynamic>>[];

  for (var group in tagGroups) {
    for (var tag in group.tags) {
      jsonList.add(tag.toJson());
    }
  }
  return jsonList;
}
