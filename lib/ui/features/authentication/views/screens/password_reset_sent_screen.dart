import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PasswordResetSentScreen extends StatelessWidget {

  const PasswordResetSentScreen({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: ThemeApp.backgroundColor,
           body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(height: 20),
              Text("If this way as valid email, instructions to reset your password will be sent to you. Please check your email."),
              Positioned(
                top: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeApp.buttonPurpleColor
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: const Text('Login', style: TextStyle(color: ThemeApp.buttonPurpleColor),),
                ),
              ),
            ],
           ),
       );
  }
}