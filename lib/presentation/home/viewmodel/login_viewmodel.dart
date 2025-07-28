import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Hata mesajı göster
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      // TODO: AuthService ile giriş işlemini bağlayın
      await Future.delayed(const Duration(seconds: 2)); // Simüle edilmiş giriş
    } catch (e) {
      // Hata durumunu yönetin
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}