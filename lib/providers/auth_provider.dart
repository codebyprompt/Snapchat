import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _phoneNumber = '';
  String _verificationCode = '';
  String _userName = '';
  String _email = '';

  bool get isLoading => _isLoading;
  String get phoneNumber => _phoneNumber;
  String get verificationCode => _verificationCode;
  String get userName => _userName;
  String get email => _email;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setVerificationCode(String value) {
    _verificationCode = value;
    notifyListeners();
  }

  void setUserName(String value) {
    _userName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    return true;
  }

  Future<bool> signup(String username, String email, String password) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    _userName = username;
    _email = email;
    setLoading(false);
    return true;
  }

  Future<bool> verifyOtp(String otp) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    return otp.length == 6;
  }
}
