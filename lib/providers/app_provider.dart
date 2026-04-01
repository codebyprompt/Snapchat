import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  int _currentPage = 2; // Camera is default (center)
  bool _isLoggedIn = false;
  bool _onboardingComplete = false;

  bool get isDarkMode => _isDarkMode;
  int get currentPage => _currentPage;
  bool get isLoggedIn => _isLoggedIn;
  bool get onboardingComplete => _onboardingComplete;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setOnboardingComplete(bool value) {
    _onboardingComplete = value;
    notifyListeners();
  }
}
