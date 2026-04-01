import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryProvider extends ChangeNotifier {
  List<StoryModel> _stories = StoryModel.mockStories;
  List<DiscoverItem> _discoverItems = DiscoverItem.mockDiscover;

  List<StoryModel> get stories => _stories;
  List<StoryModel> get unviewedStories =>
      _stories.where((s) => !s.isViewed).toList();
  List<StoryModel> get viewedStories =>
      _stories.where((s) => s.isViewed).toList();
  List<DiscoverItem> get discoverItems => _discoverItems;

  void markStoryAsViewed(String storyId) {
    final index = _stories.indexWhere((s) => s.id == storyId);
    if (index != -1) {
      final old = _stories[index];
      _stories[index] = StoryModel(
        id: old.id,
        userId: old.userId,
        username: old.username,
        userAvatar: old.userAvatar,
        items: old.items,
        isViewed: true,
        postedAt: old.postedAt,
      );
      notifyListeners();
    }
  }
}
