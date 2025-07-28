import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().checkUserSession(context);
    });

    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}