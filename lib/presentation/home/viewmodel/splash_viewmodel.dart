import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/login_page.dart';
import '../view/home_page.dart';
import '../viewmodel/auth_viewmodel.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> checkUserSession(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // Kullanıcı oturum durumunu kontrol et
    final isLoggedIn = authViewModel.loginModel != null;

    // Yönlendirme
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}