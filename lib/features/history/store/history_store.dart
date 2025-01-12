import 'package:flutter/material.dart';

import '../../auth/store/models/user_model.dart';
import 'services/history_service.dart';

class HistoryStore extends ChangeNotifier {
  List<TagsModel> _tagsList = [];
  List<TagsModel> get tagsList => _tagsList;
  Future<void> loadTags() async {
    final data = await HistoryService.getTagsList();
    _tagsList = data.map(TagsModel.fromJson).toList();
    notifyListeners();
  }
}
