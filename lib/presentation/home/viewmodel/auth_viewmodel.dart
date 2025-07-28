import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel(this._authService);

  // Ortak controllerlar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  // Şifre gizleme
  bool _obscure1 = true;
  bool get obscure1 => _obscure1;
  void toggleObscure1() {
    _obscure1 = !_obscure1;
    notifyListeners();
  }

  bool _obscure2 = true;
  bool get obscure2 => _obscure2;
  void toggleObscure2() {
    _obscure2 = !_obscure2;
    notifyListeners();
  }

  // Şifre 1 için toggle fonksiyonu (register ve login için ortak)
  void togglePasswordVisibility() {
    _obscure1 = !_obscure1;
    notifyListeners();
  }

  // Login için backward compatibility: obscurePassword getter
  bool get obscurePassword => _obscure1;

  // Kullanıcı sözleşmesi
  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  // Auth durumları
  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> login() async {
    _setLoading(true);
    try {
      _user = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Giriş başarısız: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register() async {
    _setLoading(true);
    try {
      _user = await _authService.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Kayıt başarısız: $e';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    repeatPasswordController.clear();
  }
}
