import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/app_provider.dart';
import 'camera_screen.dart';
import 'chat/chat_list_screen.dart';
import 'stories/stories_screen.dart';
import 'discover/discover_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 2; // Camera is center (default)
  late AnimationController _navAnimController;
  late Animation<double> _navAnimation;

  final List<Widget> _screens = const [
    ProfileScreen(),
    ChatListScreen(),
    CameraScreen(),
    StoriesScreen(),
    DiscoverScreen(),
  ];

  final List<IconData> _icons = [
    Icons.person_rounded,
    Icons.chat_bubble_rounded,
    Icons.camera_alt_rounded,
    Icons.auto_stories_rounded,
    Icons.explore_rounded,
  ];

  final List<IconData> _outlinedIcons = [
    Icons.person_outline_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.camera_alt_outlined,
    Icons.auto_stories_outlined,
    Icons.explore_outlined,
  ];

  final List<String> _labels = [
    'Profile',
    'Chat',
    'Camera',
    'Stories',
    'Discover',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _navAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _navAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _navAnimController, curve: Curves.easeOut),
    );
    _navAnimController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navAnimController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    context.read<AppProvider>().setCurrentPage(page);
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Pages
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _screens,
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _navAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1A1A1A).withOpacity(0.95)
                      : Colors.white.withOpacity(0.95),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (index) {
                        final isSelected = _currentPage == index;
                        final isCamera = index == 2;
                        return GestureDetector(
                          onTap: () => _onNavTap(index),
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelected && !isCamera ? 16 : 12,
                              vertical: 8,
                            ),
                            decoration: isCamera
                                ? BoxDecoration(
                                    color: isSelected
                                        ? AppColors.snapYellow
                                        : (isDark
                                            ? Colors.white.withOpacity(0.1)
                                            : Colors.grey.withOpacity(0.15)),
                                    shape: BoxShape.circle,
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: AppColors.snapYellow
                                                  .withOpacity(0.4),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  )
                                : isSelected
                                    ? BoxDecoration(
                                        color: isDark
                                            ? Colors.white.withOpacity(0.1)
                                            : Colors.black.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    isSelected
                                        ? _icons[index]
                                        : _outlinedIcons[index],
                                    key: ValueKey('$index-$isSelected'),
                                    size: isCamera ? 28 : 24,
                                    color: isCamera
                                        ? (isSelected
                                            ? Colors.black
                                            : (isDark
                                                ? Colors.white60
                                                : Colors.grey))
                                        : (isSelected
                                            ? (isDark
                                                ? Colors.white
                                                : Colors.black)
                                            : (isDark
                                                ? Colors.white60
                                                : Colors.grey)),
                                  ),
                                ),
                                if (!isCamera) ...[
                                  const SizedBox(height: 4),
                                  AnimatedDefaultTextStyle(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? (isDark
                                              ? Colors.white
                                              : Colors.black)
                                          : (isDark
                                              ? Colors.white60
                                              : Colors.grey),
                                    ),
                                    child: Text(_labels[index]),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
