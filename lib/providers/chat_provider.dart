import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatThread> _chatThreads = ChatThread.mockChats;
  final Map<String, List<ChatMessage>> _messages = {};

  List<ChatThread> get chatThreads => _chatThreads;

  List<ChatMessage> getMessages(String threadId) {
    if (!_messages.containsKey(threadId)) {
      _messages[threadId] = ChatThread.getMockMessages(threadId);
    }
    return _messages[threadId]!;
  }

  void sendMessage(String threadId, String content) {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: '1',
      receiverId: threadId,
      content: content,
      type: MessageType.text,
      status: MessageStatus.sent,
      timestamp: DateTime.now(),
      isMe: true,
    );

    if (!_messages.containsKey(threadId)) {
      _messages[threadId] = ChatThread.getMockMessages(threadId);
    }
    _messages[threadId]!.add(message);

    // Update last message in thread
    final threadIndex = _chatThreads.indexWhere((t) => t.id == threadId);
    if (threadIndex != -1) {
      final oldThread = _chatThreads[threadIndex];
      _chatThreads[threadIndex] = ChatThread(
        id: oldThread.id,
        friendId: oldThread.friendId,
        friendName: oldThread.friendName,
        friendAvatar: oldThread.friendAvatar,
        lastMessage: content,
        lastMessageTime: DateTime.now(),
        lastMessageStatus: MessageStatus.sent,
        lastMessageType: MessageType.text,
        isOnline: oldThread.isOnline,
        unreadCount: 0,
        streak: oldThread.streak,
      );
      // Move to top
      final thread = _chatThreads.removeAt(threadIndex);
      _chatThreads.insert(0, thread);
    }

    notifyListeners();

    // Simulate reply after delay
    Future.delayed(const Duration(seconds: 2), () {
      _simulateReply(threadId);
    });
  }

  void _simulateReply(String threadId) {
    final replies = [
      'That\'s awesome! 🎉',
      'Haha no way! 😂',
      'Tell me more!',
      'Cool! 🔥',
      'I totally agree!',
      'Let\'s do it! 💪',
      'OMG really? 😮',
      'Sounds great!',
    ];

    final reply = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: threadId,
      receiverId: '1',
      content: replies[DateTime.now().second % replies.length],
      type: MessageType.text,
      status: MessageStatus.read,
      timestamp: DateTime.now(),
      isMe: false,
    );

    _messages[threadId]?.add(reply);
    notifyListeners();
  }

  void markAsRead(String threadId) {
    final threadIndex = _chatThreads.indexWhere((t) => t.id == threadId);
    if (threadIndex != -1) {
      final oldThread = _chatThreads[threadIndex];
      _chatThreads[threadIndex] = ChatThread(
        id: oldThread.id,
        friendId: oldThread.friendId,
        friendName: oldThread.friendName,
        friendAvatar: oldThread.friendAvatar,
        lastMessage: oldThread.lastMessage,
        lastMessageTime: oldThread.lastMessageTime,
        lastMessageStatus: MessageStatus.read,
        lastMessageType: oldThread.lastMessageType,
        isOnline: oldThread.isOnline,
        unreadCount: 0,
        streak: oldThread.streak,
      );
    }
    notifyListeners();
  }
}
