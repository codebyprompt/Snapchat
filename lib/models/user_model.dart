class UserModel {
  final String id;
  final String username;
  final String displayName;
  final String avatarUrl;
  final String snapScore;
  final String bio;
  final bool isOnline;
  final DateTime? lastSeen;

  UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    this.snapScore = '0',
    this.bio = '',
    this.isOnline = false,
    this.lastSeen,
  });

  static UserModel mockUser = UserModel(
    id: '1',
    username: 'john_doe',
    displayName: 'John Doe',
    avatarUrl: 'https://i.pravatar.cc/300?img=1',
    snapScore: '125,430',
    bio: 'Living my best life ✨',
    isOnline: true,
  );

  static List<UserModel> mockFriends = [
    UserModel(
      id: '2',
      username: 'emma_w',
      displayName: 'Emma Wilson',
      avatarUrl: 'https://i.pravatar.cc/300?img=5',
      snapScore: '89,200',
      isOnline: true,
    ),
    UserModel(
      id: '3',
      username: 'alex_smith',
      displayName: 'Alex Smith',
      avatarUrl: 'https://i.pravatar.cc/300?img=3',
      snapScore: '234,100',
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    UserModel(
      id: '4',
      username: 'sarah_j',
      displayName: 'Sarah Johnson',
      avatarUrl: 'https://i.pravatar.cc/300?img=9',
      snapScore: '56,780',
      isOnline: true,
    ),
    UserModel(
      id: '5',
      username: 'mike_brown',
      displayName: 'Mike Brown',
      avatarUrl: 'https://i.pravatar.cc/300?img=12',
      snapScore: '312,500',
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    UserModel(
      id: '6',
      username: 'lisa_chen',
      displayName: 'Lisa Chen',
      avatarUrl: 'https://i.pravatar.cc/300?img=16',
      snapScore: '178,900',
      isOnline: true,
    ),
    UserModel(
      id: '7',
      username: 'david_k',
      displayName: 'David Kim',
      avatarUrl: 'https://i.pravatar.cc/300?img=11',
      snapScore: '445,200',
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    UserModel(
      id: '8',
      username: 'jessica_l',
      displayName: 'Jessica Lee',
      avatarUrl: 'https://i.pravatar.cc/300?img=20',
      snapScore: '67,300',
      isOnline: true,
    ),
  ];
}
