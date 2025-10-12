import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/store/auth_store.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    await _authStore.checkAuthState();
    
    if (!mounted) return;
    
    if (_authStore.currentUser != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
       Navigator.pushNamedAndRemoveUntil(context, '/signup', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}