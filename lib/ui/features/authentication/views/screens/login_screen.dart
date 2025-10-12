import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/store/auth_store.dart';
import 'package:desafio_loomi/ui/features/authentication/views/screens/forgot_password_screen.dart';
import 'package:desafio_loomi/ui/features/authentication/views/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _authStore = getIt<AuthStore>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/logo.png',
                width: 48,
                height: 48,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Look who is here!',
                style: TextStyle(
                  color: ThemeApp.textColorMuted,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.purple[300],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Observer(
                builder: (_) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _authStore.isLoading
                        ? null
                        : () => _handleLogin(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(186, 76, 241, 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _authStore.isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFF2A2A2A))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or Sign in With',
                      style: TextStyle(
                        color: ThemeApp.textColorMuted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFF2A2A2A))),
                ],
              ),
              const SizedBox(height: 24),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      child: GestureDetector(
                        onTap: () => _handleGoogleSignIn(context),
                        child: Image.asset("assets/images/google_logo.png")),
                    ),
                   
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 60,
                      child: GestureDetector(
                        onTap: () => _handleAppleSignIn(context),
                        child: Image.asset("assets/images/apple_logo.png")),
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    color: ThemeApp.textColorMuted,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up!',
                      style: TextStyle(
                        color: Colors.purple[300],
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    final success = await _authStore.signInWithEmail(
      _emailController.text,
      _passwordController.text,
    );
    
    if (!context.mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authStore.errorMessage ?? 'Login failed')),
      );
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final success = await _authStore.signInWithGoogle();
    if (!context.mounted) return;
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _handleAppleSignIn(BuildContext context) async {
    final success = await _authStore.signInWithApple();
    if (!context.mounted) return;
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}