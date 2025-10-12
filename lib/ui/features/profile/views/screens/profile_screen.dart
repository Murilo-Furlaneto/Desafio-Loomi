import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:desafio_loomi/ui/features/authentication/store/auth_store.dart';
import 'package:desafio_loomi/ui/features/profile/store/profile_store.dart';
import 'package:desafio_loomi/ui/features/profile/views/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<Map<String, dynamic>> historyItems = const [
    {'title': 'Barbie', 'year': '2023', 'color': Color(0xFFE91E63)},
    {'title': 'EVERYTHING EVERYWHERE ALL AT ONCE', 'year': '2022', 'color': Color(0xFF673AB7)},
    {'title': 'Movie Title 3', 'year': '2023', 'color': Color(0xFF00BCD4)},
    {'title': 'Movie Title 4', 'year': '2023', 'color': Color(0xFFFDD835)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeApp.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeApp.primaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 0, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16), 

            const ProfileHeader(),
            
            const SizedBox(height: 16),

            ProfileMenuItem(
              title: 'Change Password',
              icon: Icons.lock_outline,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
              },
            ),
            ProfileMenuItem(
              title: 'Delete my account',
              icon: Icons.delete_outline,
              onTap: () {
                getIt<ProfileStore>().deleteUserAccount();
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              'Subscriptions',
              style: TextStyle(
                color: ThemeApp.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _SubscriptionCard(), 
            
            const SizedBox(height: 32),

            const Text(
              'History',
              style: TextStyle(
                color: ThemeApp.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _HistoryGrid(historyItems: historyItems), 

            const SizedBox(height: 32),

            Center(
              child: TextButton(
                onPressed: () {
                  getIt<AuthStore>().signOut();
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: ThemeApp.secondaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThemeApp.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ThemeApp.primaryPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.stream, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'STREAM Premium',
                    style: TextStyle(
                      color: ThemeApp.primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Jan 22, 2023',
                    style: TextStyle(
                      color: ThemeApp.secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Text(
            'Coming soon',
            style: TextStyle(
              color: ThemeApp.primaryPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


class _HistoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> historyItems;

  const _HistoryGrid({required this.historyItems});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Padding(
            padding: EdgeInsets.only(right: index == historyItems.length - 1 ? 0 : 16.0),
            child: SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: item['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item['title'].toString().split(' ')[0], 
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['title'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ThemeApp.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    item['year'] as String,
                    style: const TextStyle(
                      color: ThemeApp.secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
