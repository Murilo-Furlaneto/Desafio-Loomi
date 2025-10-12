import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/routes/app_routes.dart';
import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/store/auth_store.dart';
import 'package:desafio_loomi/ui/features/authentication/views/widgets/custom_text_field.dart';
import 'package:desafio_loomi/ui/features/profile/views/screens/profile_completion_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
    final _authStore = getIt<AuthStore>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor, 
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo_text.png",
                      height: 120,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
         
                  ],
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      color: ThemeApp.textColorMuted,
                      fontSize: 14,
                      fontWeight: FontApp.light,
                    ),
                    children:  [
                      TextSpan(
                        text: "Sign In!",
                        style: TextStyle(
                          color: Color(0xFFAA73F0),
                          fontSize: 14,
                          fontWeight: FontApp.light,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Create an account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontApp.large,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "To get started, please complete your account registration.",
                  style: TextStyle(
                    color: ThemeApp.textColorMuted,
                    fontSize: 14,
                    fontWeight: FontApp.light
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 25),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(color: Colors.grey, thickness: 0.5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or Sign up With",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey, thickness: 0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  hintText: 'Email', controller: _emailController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Password',
                  obscureText: true, controller: _passwordController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Confirm your Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                     _authStore.signInWithEmail(_emailController.text, _passwordController.text);
                     if (!context.mounted) return;
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfileCompletionScreen()), (context) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(186, 76, 241, 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final success = await _authStore.signInWithGoogle();
    if (!context.mounted) return;
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/profileCompletion');
    }
  }

  Future<void> _handleAppleSignIn(BuildContext context) async {
    final success = await _authStore.signInWithApple();
    if (!context.mounted) return;
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/profileCompletion');
    }
  }
}




