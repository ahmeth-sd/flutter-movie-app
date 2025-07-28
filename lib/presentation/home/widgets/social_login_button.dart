import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;

  const SocialLoginButton({required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}