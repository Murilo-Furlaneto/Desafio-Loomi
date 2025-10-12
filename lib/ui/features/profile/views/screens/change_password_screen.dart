import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/views/widgets/custom_text_field.dart';
import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/ui/features/profile/store/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  final ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitChangePassword() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Esconde o teclado
      
      final currentPassword = _currentPasswordController.text.trim();
      final newPassword = _newPasswordController.text.trim();

      bool success = await _profileStore.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmNewPasswordController.clear();
        Navigator.of(context).pop();
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_profileStore.errorMessage ?? 'An unknown error occurred.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: ThemeApp.primaryTextColor),
        ),
        backgroundColor: ThemeApp.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: ThemeApp.primaryTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter your current password and new password to update your account security.',
                style: TextStyle(color: ThemeApp.secondaryTextColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              
              CustomTextField(
                controller: _currentPasswordController,
                hintText: 'Current Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                }, 
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: _newPasswordController,
                hintText: 'New Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: _confirmNewPasswordController,
                hintText: 'Confirm New Password',
                obscureText: true,
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              Observer(
                builder: (_) {
                  return ElevatedButton(
                    onPressed: _profileStore.isLoading ? null : _submitChangePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _profileStore.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Change Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
