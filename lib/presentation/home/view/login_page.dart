import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/widgets/custom_text_field.dart';
import '../viewmodel/login_viewmodel.dart';
import '../widgets/social_login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Merhabalar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Tempus varius a vitae interdum id\ntortor elementum tristique eleifend at.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Email input
                CustomTextField(
                  controller: viewModel.emailController,
                  icon: Icons.mail_outline,
                  hint: "E-Posta",
                ),

                const SizedBox(height: 16),

                // Password input
                CustomTextField(
                  controller: viewModel.passwordController,
                  icon: Icons.lock_outline,
                  hint: "Şifre",
                  obscure: viewModel.obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: viewModel.togglePasswordVisibility,
                  ),
                ),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Şifremi unuttum
                    },
                    child: const Text(
                      "Şifremi unuttum",
                      style: TextStyle(
                          color: Colors.white, decoration: TextDecoration.underline),
                    ),
                  ),
                ),

                // Giriş Yap butonu
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () {
                      viewModel.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Giriş Yap",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sosyal girişler
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SocialLoginButton(icon: Icons.g_mobiledata), // Google
                    SocialLoginButton(icon: Icons.apple),
                    SocialLoginButton(icon: Icons.facebook),
                  ],
                ),

                const SizedBox(height: 24),

                // Kayıt Ol
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bir hesabın yok mu?",
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Register sayfasına git
                      },
                      child: const Text(
                        "Kayıt Ol!",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}