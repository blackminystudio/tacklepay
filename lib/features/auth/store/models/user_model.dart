class UserModel {
  final SummaryModel summaryModel;
  final List<TagsModel> tagsModel;

  UserModel({
    required this.summaryModel,
    required this.tagsModel,
  });

  Map<String, dynamic> toJson() => {
        'summaryModel': summaryModel.toJson(),
        'tagsModel': tagsModel.map((tag) => tag.toJson()).toList(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        summaryModel:
            SummaryModel.fromJson(json['summaryModel'] as Map<String, dynamic>),
        tagsModel: (json['tagsModel'] as List)
            .map((tagJson) =>
                TagsModel.fromJson(tagJson as Map<String, dynamic>))
            .toList(),
      );
}

class SummaryModel {
  final int prevMonthExpense;
  final int prevMonthIncome;
  final int thisMonthExpense;
  final int thisMonthIncome;

  SummaryModel({
    required this.prevMonthExpense,
    required this.prevMonthIncome,
    required this.thisMonthExpense,
    required this.thisMonthIncome,
  });

  Map<String, dynamic> toJson() => {
        'previousMonthExpense': prevMonthExpense,
        'previousMonthIncome': prevMonthIncome,
        'thisMonthExpense': thisMonthExpense,
        'thisMonthIncome': thisMonthIncome,
      };

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        prevMonthExpense: (json['previousMonthExpense'] as num?)?.toInt() ?? 0,
        prevMonthIncome: (json['previousMonthIncome'] as num?)?.toInt() ?? 0,
        thisMonthExpense: (json['thisMonthExpense'] as num?)?.toInt() ?? 0,
        thisMonthIncome: (json['thisMonthIncome'] as num?)?.toInt() ?? 0,
      );
}

class TagsModel {
  String id;
  String name;

  TagsModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory TagsModel.fromJson(Map<String, dynamic> json) => TagsModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
      );

  String getInitial() => name[0].toUpperCase();
}
