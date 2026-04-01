import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../models/chat_model.dart';
import '../../providers/chat_provider.dart';
import 'chat_conversation_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0D0D) : Colors.white,
      body: SafeArea(
        bottom: false,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chat',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        _buildHeaderButton(
                          icon: Icons.search_rounded,
                          isDark: isDark,
                        ),
                        const SizedBox(width: 8),
                        _buildHeaderButton(
                          icon: Icons.group_add_rounded,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chat list
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatProvider.chatThreads.length,
                      itemBuilder: (context, index) {
                        final chat = chatProvider.chatThreads[index];
                        return _buildChatTile(context, chat, index, isDark);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDark ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildChatTile(
      BuildContext context, ChatThread chat, int index, bool isDark) {
    final isUnread = chat.unreadCount > 0;
    final isSnap = chat.lastMessageType == MessageType.snap;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ChatConversationScreen(chatThread: chat),
              transitionDuration: const Duration(milliseconds: 350),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: Colors.transparent,
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSnap && isUnread
                          ? AppColors.blueGradient
                          : null,
                      color: isSnap && isUnread
                          ? null
                          : (isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.15)),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(chat.friendAvatar),
                    ),
                  ),
                  if (chat.isOnline)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.chatGreen,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF0D0D0D)
                                : Colors.white,
                            width: 2.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Chat info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.friendName,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        if (chat.streak > 0) ...[
                          Text(
                            '🔥',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${chat.streak}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFF9500),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (isSnap)
                          Icon(
                            chat.lastMessageStatus == MessageStatus.opened
                                ? Icons.crop_square_rounded
                                : Icons.square_rounded,
                            size: 14,
                            color: isUnread
                                ? AppColors.chatRed
                                : (isDark ? Colors.white38 : Colors.black38),
                          ),
                        if (!isSnap && chat.lastMessageStatus != MessageStatus.read)
                          Icon(
                            Icons.chat_bubble_rounded,
                            size: 12,
                            color: isUnread
                                ? AppColors.chatBlue
                                : (isDark ? Colors.white38 : Colors.black38),
                          ),
                        if (isSnap || chat.lastMessageStatus != MessageStatus.read)
                          const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: isUnread
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isUnread
                                  ? (isDark ? Colors.white : Colors.black)
                                  : (isDark
                                      ? Colors.white54
                                      : Colors.black45),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getTimeAgo(chat.lastMessageTime),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Camera icon
              const SizedBox(width: 8),
              Icon(
                Icons.camera_alt_outlined,
                size: 20,
                color: isDark
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
