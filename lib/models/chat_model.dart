enum MessageType { text, snap, image, sticker }
enum MessageStatus { sent, delivered, read, opened }

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    this.isMe = false,
  });
}

class ChatThread {
  final String id;
  final String friendId;
  final String friendName;
  final String friendAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final MessageStatus lastMessageStatus;
  final MessageType lastMessageType;
  final bool isOnline;
  final int unreadCount;
  final int streak;

  ChatThread({
    required this.id,
    required this.friendId,
    required this.friendName,
    required this.friendAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageStatus,
    required this.lastMessageType,
    this.isOnline = false,
    this.unreadCount = 0,
    this.streak = 0,
  });

  static List<ChatThread> mockChats = [
    ChatThread(
      id: '1',
      friendId: '2',
      friendName: 'Emma Wilson',
      friendAvatar: 'https://i.pravatar.cc/300?img=5',
      lastMessage: 'Haha that\'s so funny! 😂',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 2)),
      lastMessageStatus: MessageStatus.read,
      lastMessageType: MessageType.text,
      isOnline: true,
      unreadCount: 0,
      streak: 15,
    ),
    ChatThread(
      id: '2',
      friendId: '3',
      friendName: 'Alex Smith',
      friendAvatar: 'https://i.pravatar.cc/300?img=3',
      lastMessage: 'New Snap',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      lastMessageStatus: MessageStatus.delivered,
      lastMessageType: MessageType.snap,
      isOnline: false,
      unreadCount: 1,
      streak: 32,
    ),
    ChatThread(
      id: '3',
      friendId: '4',
      friendName: 'Sarah Johnson',
      friendAvatar: 'https://i.pravatar.cc/300?img=9',
      lastMessage: 'See you tonight! 🎉',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      lastMessageStatus: MessageStatus.read,
      lastMessageType: MessageType.text,
      isOnline: true,
      unreadCount: 0,
      streak: 7,
    ),
    ChatThread(
      id: '4',
      friendId: '5',
      friendName: 'Mike Brown',
      friendAvatar: 'https://i.pravatar.cc/300?img=12',
      lastMessage: 'Sent you a snap',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      lastMessageStatus: MessageStatus.opened,
      lastMessageType: MessageType.snap,
      isOnline: false,
      unreadCount: 0,
      streak: 45,
    ),
    ChatThread(
      id: '5',
      friendId: '6',
      friendName: 'Lisa Chen',
      friendAvatar: 'https://i.pravatar.cc/300?img=16',
      lastMessage: 'That place looks amazing!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
      lastMessageStatus: MessageStatus.read,
      lastMessageType: MessageType.text,
      isOnline: true,
      unreadCount: 0,
      streak: 0,
    ),
    ChatThread(
      id: '6',
      friendId: '7',
      friendName: 'David Kim',
      friendAvatar: 'https://i.pravatar.cc/300?img=11',
      lastMessage: 'New Snap',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 8)),
      lastMessageStatus: MessageStatus.delivered,
      lastMessageType: MessageType.snap,
      isOnline: false,
      unreadCount: 2,
      streak: 120,
    ),
    ChatThread(
      id: '7',
      friendId: '8',
      friendName: 'Jessica Lee',
      friendAvatar: 'https://i.pravatar.cc/300?img=20',
      lastMessage: 'Miss you! 💕',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      lastMessageStatus: MessageStatus.read,
      lastMessageType: MessageType.text,
      isOnline: true,
      unreadCount: 0,
      streak: 3,
    ),
  ];

  static List<ChatMessage> getMockMessages(String threadId) {
    return [
      ChatMessage(
        id: '1',
        senderId: '1',
        receiverId: '2',
        content: 'Hey! What\'s up? 👋',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: true,
      ),
      ChatMessage(
        id: '2',
        senderId: '2',
        receiverId: '1',
        content: 'Not much! Just chilling at home 🏠',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      ),
      ChatMessage(
        id: '3',
        senderId: '1',
        receiverId: '2',
        content: 'Wanna grab coffee later? ☕',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        isMe: true,
      ),
      ChatMessage(
        id: '4',
        senderId: '2',
        receiverId: '1',
        content: 'Yes!! That sounds great! Where do you wanna go?',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      ),
      ChatMessage(
        id: '5',
        senderId: '1',
        receiverId: '2',
        content: 'How about that new place downtown? I heard they have amazing lattes 🎉',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        isMe: true,
      ),
      ChatMessage(
        id: '6',
        senderId: '2',
        receiverId: '1',
        content: 'Perfect! Let\'s meet at 4pm?',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      ),
      ChatMessage(
        id: '7',
        senderId: '1',
        receiverId: '2',
        content: 'Sounds good! See you there 😊',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 25)),
        isMe: true,
      ),
      ChatMessage(
        id: '8',
        senderId: '2',
        receiverId: '1',
        content: 'Haha that\'s so funny! 😂',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
    ];
  }
}
