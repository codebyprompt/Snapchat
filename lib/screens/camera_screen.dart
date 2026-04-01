import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin {
  bool _isFlashOn = false;
  bool _isFrontCamera = true;
  bool _isCapturing = false;
  late AnimationController _captureController;
  late Animation<double> _captureAnimation;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _captureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _captureAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _captureController, curve: Curves.easeInOut),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _captureController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onCapture() {
    _captureController.forward().then((_) {
      _captureController.reverse();
    });
    setState(() => _isCapturing = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _isCapturing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera preview placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        _isFrontCamera
                            ? Icons.face_retouching_natural_rounded
                            : Icons.landscape_rounded,
                        size: 80,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Camera Preview',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Flash overlay
          if (_isCapturing)
            AnimatedOpacity(
              opacity: _isCapturing ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                color: Colors.white,
              ),
            ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile icon
                  _buildTopButton(
                    icon: Icons.person_rounded,
                    onTap: () {},
                    hasGlow: true,
                  ),
                  // Top center icons
                  Row(
                    children: [
                      _buildTopButton(
                        icon: Icons.search_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                  // Add friend
                  _buildTopButton(
                    icon: Icons.person_add_alt_1_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Right side controls
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                _buildSideButton(
                  icon: _isFlashOn
                      ? Icons.flash_on_rounded
                      : Icons.flash_off_rounded,
                  onTap: () {
                    setState(() => _isFlashOn = !_isFlashOn);
                  },
                  isActive: _isFlashOn,
                ),
                const SizedBox(height: 20),
                _buildSideButton(
                  icon: Icons.flip_camera_ios_rounded,
                  onTap: () {
                    setState(() => _isFrontCamera = !_isFrontCamera);
                  },
                ),
                const SizedBox(height: 20),
                _buildSideButton(
                  icon: Icons.music_note_rounded,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildSideButton(
                  icon: Icons.nightlight_round,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Lens carousel
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final colors = [
                        const Color(0xFFFF6B6B),
                        const Color(0xFF4ECDC4),
                        const Color(0xFFFFE66D),
                        const Color(0xFFA8E6CF),
                        const Color(0xFFFF8B94),
                        const Color(0xFFDDA0DD),
                        const Color(0xFF98D8C8),
                        const Color(0xFFF7DC6F),
                      ];
                      final icons = [
                        Icons.face_rounded,
                        Icons.pets_rounded,
                        Icons.star_rounded,
                        Icons.favorite_rounded,
                        Icons.emoji_emotions_rounded,
                        Icons.auto_awesome_rounded,
                        Icons.filter_vintage_rounded,
                        Icons.wb_sunny_rounded,
                      ];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: colors[index].withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colors[index].withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              icons[index],
                              color: colors[index],
                              size: 28,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Capture button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gallery
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.photo_library_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),

                    // Main capture button
                    GestureDetector(
                      onTap: _onCapture,
                      onLongPress: () {},
                      child: AnimatedBuilder(
                        animation: _captureAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _captureAnimation.value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),

                    // Emoji
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.emoji_emotions_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasGlow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
          boxShadow: hasGlow
              ? [
                  BoxShadow(
                    color: AppColors.snapYellow.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildSideButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.snapYellow.withOpacity(0.9)
              : Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.black : Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
