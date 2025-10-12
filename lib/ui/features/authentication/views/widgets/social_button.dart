import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const SocialButton({super.key, 
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}