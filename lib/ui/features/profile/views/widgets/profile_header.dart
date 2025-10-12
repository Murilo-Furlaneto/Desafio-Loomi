import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/profile/store/profile_store.dart';
import 'package:desafio_loomi/ui/features/profile/views/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:desafio_loomi/di/service_locator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void initState() {
    super.initState();
    _profileStore.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final user = _profileStore.user;
        final isLoading = _profileStore.isLoading;
        final username = user?.displayName ?? 'Não foi possível carregar o nome do usuário';
        final photoUrl = user?.photoUrl;

        if (isLoading && user == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: CircularProgressIndicator(color: ThemeApp.primaryPurple),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: ThemeApp.primaryPurple.withOpacity(0.5),
                    backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                        ? NetworkImage(photoUrl) as ImageProvider
                        : null,
                    child: (photoUrl == null || photoUrl.isEmpty)
                        ? const Icon(Icons.person, color: Colors.white, size: 32)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                            color: ThemeApp.secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          username,
                          style: const TextStyle(
                            color: ThemeApp.primaryTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                        side: const BorderSide(color: ThemeApp.primaryPurple, width: 1.5),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: ThemeApp.primaryPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (_profileStore.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Error: ${_profileStore.errorMessage}',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
