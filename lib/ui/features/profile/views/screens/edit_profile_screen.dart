import 'dart:async';

import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/ui/features/profile/store/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _profileStore = getIt<ProfileStore>();
  
  Timer? _timer;
  bool _loadingTimedOut = false;

  @override
  void initState() {
    super.initState();
    _profileStore.fetchUserProfile();
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted && _profileStore.user == null) {
        setState(() {
          _loadingTimedOut = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.white : ThemeApp.primaryPurple,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: ThemeApp.primaryTextColor),
        ),
        backgroundColor: ThemeApp.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeApp.primaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Observer(
        builder: (_) {
          if (_profileStore.user == null) {
            if (_loadingTimedOut) {
              return const Center(
                child: Text(
                  'Não foi possível carregar os dados.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(color: ThemeApp.primaryPurple));
          }
          if(_profileStore.errorMessage != null){
            return Center(child: Text(_profileStore.errorMessage ?? 'Erro desconhecido', style: const TextStyle(color: Colors.red)));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(_profileStore.user?.photoUrl ?? 'https://i.pravatar.cc/150?img=48'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _showSnackbar('Função de Alterar Foto pendente.', isError: false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ThemeApp.primaryPurple,
                                shape: BoxShape.circle,
                                border: Border.all(color: ThemeApp.backgroundColor, width: 3),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: ThemeApp.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ThemeApp.buttonPurpleColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nome de Usuário',
                          style: TextStyle(
                            color: ThemeApp.secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _profileStore.user?.displayName ?? 'Não foi possível carregar o nome do usuário',
                          style: const TextStyle(
                            color: ThemeApp.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      _showSnackbar('Navegação para Mudar Senha (ChangePasswordScreen) pendente.', isError: false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}