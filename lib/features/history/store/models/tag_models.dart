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
  {'id': '3', 'name': 'Basket'},
  {'id': '4', 'name': 'Big'},
  {'id': '5', 'name': 'Bowl'},
  {'id': '6', 'name': 'Cat'},
  {'id': '7', 'name': 'Cake'},
];

//  Convet list of tag to List<TagGroup>
List<TagGroup> groupTagsAlphabetically(List<Tag> tags) {
  final grouped = <String, List<Tag>>{};

  for (var tag in tags) {
    final groupName = tag.name[0].toUpperCase();
    if (!grouped.containsKey(groupName)) {
      grouped[groupName] = [];
    }
    grouped[groupName]!.add(tag);
  }

  return grouped.entries
      .map((entry) => TagGroup(groupName: entry.key, tags: entry.value))
      .toList();
}
