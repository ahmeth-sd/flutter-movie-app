import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/widgets/social_login_button.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Hesabınızı oluşturun ve hemen başlayın!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 32),

                CustomTextField(
                  controller: authViewModel.nameController,
                  icon: Icons.person,
                  hint: "Ad Soyad",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: authViewModel.emailController,
                  icon: Icons.email,
                  hint: "E-Posta",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: authViewModel.passwordController,
                  icon: Icons.lock,
                  hint: "Şifre",
                  obscure: authViewModel.obscure1,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authViewModel.obscure1 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: authViewModel.togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: authViewModel.repeatPasswordController,
                  icon: Icons.lock,
                  hint: "Şifre Tekrar",
                  obscure: authViewModel.obscure2,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authViewModel.obscure2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: authViewModel.toggleObscure2,
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: authViewModel.termsAccepted,
                      onChanged: (val) => authViewModel.setTermsAccepted(val ?? false),
                      side: const BorderSide(color: Colors.white70),
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "Kullanıcı sözleşmesini ",
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                          children: [
                            TextSpan(
                              text: "okudum ve kabul ediyorum.",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!authViewModel.termsAccepted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Lütfen sözleşmeyi kabul edin")));
                        return;
                      }

                      final name = authViewModel.nameController.text.trim();
                      final email = authViewModel.emailController.text.trim();
                      final pass1 = authViewModel.passwordController.text;
                      final pass2 = authViewModel.repeatPasswordController.text;

                      if (pass1 != pass2) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Şifreler eşleşmiyor")));
                        return;
                      }

                      await authViewModel.register();

                      if (authViewModel.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authViewModel.errorMessage!)),
                        );
                      } else {
                        // Kayıt başarılı, yönlendirme veya başka bir işlem yapılabilir
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: authViewModel.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Kayıt Ol",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SocialLoginButton(icon: Icons.g_mobiledata),
                    SocialLoginButton(icon: Icons.apple),
                    SocialLoginButton(icon: Icons.facebook),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Zaten bir hesabınız var mı?",
                        style: TextStyle(color: Colors.white54)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Login sayfasına yönlendir
                      },
                      child: const Text(
                        "Giriş Yap",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
