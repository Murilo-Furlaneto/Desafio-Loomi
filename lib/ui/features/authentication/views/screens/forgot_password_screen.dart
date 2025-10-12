import 'package:desafio_loomi/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/theme/theme.dart';
import '../../store/auth_store.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _authStore = getIt<AuthStore>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your email address to reset your password',
              style: TextStyle(
                color: ThemeApp.textColorMuted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 24),
            Observer(
              builder: (_) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _authStore.isLoading
                      ? null
                      : () => _handleResetPassword(context),
                  child: _authStore.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Send Reset Instructions'),
                ),
              ),
            ),
              SizedBox(height: 8,),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back', style: TextStyle(color: ThemeApp.buttonPurpleColor),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleResetPassword(BuildContext context) async {
    final success = await _authStore.resetPassword(_emailController.text);
    if (!context.mounted) return;
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authStore.errorMessage ?? 'An error occurred')),
      );
    }
  }
}