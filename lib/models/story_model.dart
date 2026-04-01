class StoryModel {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final List<StoryItem> items;
  final bool isViewed;
  final DateTime postedAt;

  StoryModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.items,
    this.isViewed = false,
    required this.postedAt,
  });

  static List<StoryModel> mockStories = [
    StoryModel(
      id: '1',
      userId: '2',
      username: 'Emma Wilson',
      userAvatar: 'https://i.pravatar.cc/300?img=5',
      postedAt: DateTime.now().subtract(const Duration(hours: 1)),
      items: [
        StoryItem(
          id: '1a',
          imageUrl: 'https://picsum.photos/400/800?random=1',
          caption: 'Beautiful sunset today! 🌅',
          duration: const Duration(seconds: 5),
        ),
        StoryItem(
          id: '1b',
          imageUrl: 'https://picsum.photos/400/800?random=2',
          caption: 'Coffee time ☕',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
    StoryModel(
      id: '2',
      userId: '3',
      username: 'Alex Smith',
      userAvatar: 'https://i.pravatar.cc/300?img=3',
      postedAt: DateTime.now().subtract(const Duration(hours: 2)),
      items: [
        StoryItem(
          id: '2a',
          imageUrl: 'https://picsum.photos/400/800?random=3',
          caption: 'Gym vibes 💪',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
    StoryModel(
      id: '3',
      userId: '4',
      username: 'Sarah Johnson',
      userAvatar: 'https://i.pravatar.cc/300?img=9',
      postedAt: DateTime.now().subtract(const Duration(hours: 3)),
      isViewed: true,
      items: [
        StoryItem(
          id: '3a',
          imageUrl: 'https://picsum.photos/400/800?random=4',
          caption: 'Weekend mood 🎉',
          duration: const Duration(seconds: 5),
        ),
        StoryItem(
          id: '3b',
          imageUrl: 'https://picsum.photos/400/800?random=5',
          caption: 'Party time!',
          duration: const Duration(seconds: 5),
        ),
        StoryItem(
          id: '3c',
          imageUrl: 'https://picsum.photos/400/800?random=6',
          caption: 'Best night ever ✨',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
    StoryModel(
      id: '4',
      userId: '5',
      username: 'Mike Brown',
      userAvatar: 'https://i.pravatar.cc/300?img=12',
      postedAt: DateTime.now().subtract(const Duration(hours: 5)),
      items: [
        StoryItem(
          id: '4a',
          imageUrl: 'https://picsum.photos/400/800?random=7',
          caption: 'Road trip! 🚗',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
    StoryModel(
      id: '5',
      userId: '6',
      username: 'Lisa Chen',
      userAvatar: 'https://i.pravatar.cc/300?img=16',
      postedAt: DateTime.now().subtract(const Duration(hours: 6)),
      isViewed: true,
      items: [
        StoryItem(
          id: '5a',
          imageUrl: 'https://picsum.photos/400/800?random=8',
          caption: 'Cooking something delicious 🍕',
          duration: const Duration(seconds: 5),
        ),
        StoryItem(
          id: '5b',
          imageUrl: 'https://picsum.photos/400/800?random=9',
          caption: 'Turned out amazing!',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
    StoryModel(
      id: '6',
      userId: '7',
      username: 'David Kim',
      userAvatar: 'https://i.pravatar.cc/300?img=11',
      postedAt: DateTime.now().subtract(const Duration(hours: 8)),
      items: [
        StoryItem(
          id: '6a',
          imageUrl: 'https://picsum.photos/400/800?random=10',
          caption: 'New sneakers! 👟',
          duration: const Duration(seconds: 5),
        ),
      ],
    ),
  ];
}

class StoryItem {
  final String id;
  final String imageUrl;
  final String caption;
  final Duration duration;

  StoryItem({
    required this.id,
    required this.imageUrl,
    this.caption = '',
    this.duration = const Duration(seconds: 5),
  });
}

class DiscoverItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String source;
  final bool isLarge;

  DiscoverItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.source,
    this.isLarge = false,
  });

  static List<DiscoverItem> mockDiscover = [
    DiscoverItem(
      id: '1',
      title: 'Breaking: Tech Giants Report Record Earnings',
      subtitle: 'Major tech companies exceed expectations',
      imageUrl: 'https://picsum.photos/400/300?random=20',
      source: 'TechNews',
      isLarge: true,
    ),
    DiscoverItem(
      id: '2',
      title: 'Top 10 Travel Destinations 2026',
      subtitle: 'Must visit places this year',
      imageUrl: 'https://picsum.photos/400/300?random=21',
      source: 'WanderLust',
    ),
    DiscoverItem(
      id: '3',
      title: 'New Music Drops This Week',
      subtitle: 'Latest hits you need to hear',
      imageUrl: 'https://picsum.photos/400/300?random=22',
      source: 'MusicBuzz',
    ),
    DiscoverItem(
      id: '4',
      title: 'Fitness Trends That Actually Work',
      subtitle: 'Science-backed workout tips',
      imageUrl: 'https://picsum.photos/400/300?random=23',
      source: 'FitLife',
      isLarge: true,
    ),
    DiscoverItem(
      id: '5',
      title: 'Celebrity Fashion Week Highlights',
      subtitle: 'Best looks from the runway',
      imageUrl: 'https://picsum.photos/400/300?random=24',
      source: 'StylePop',
    ),
    DiscoverItem(
      id: '6',
      title: 'Gaming: Top Releases This Month',
      subtitle: 'New games everyone is talking about',
      imageUrl: 'https://picsum.photos/400/300?random=25',
      source: 'GameZone',
    ),
    DiscoverItem(
      id: '7',
      title: 'Food Hacks That Save Time',
      subtitle: 'Quick recipes for busy people',
      imageUrl: 'https://picsum.photos/400/300?random=26',
      source: 'FoodieHub',
      isLarge: true,
    ),
    DiscoverItem(
      id: '8',
      title: 'Space Discovery: New Planet Found',
      subtitle: 'Scientists announce breakthrough',
      imageUrl: 'https://picsum.photos/400/300?random=27',
      source: 'ScienceDaily',
    ),
  ];
}
