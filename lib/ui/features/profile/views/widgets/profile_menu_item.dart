import 'package:desafio_loomi/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color backgroundColor;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = ThemeApp.primaryTextColor,
    this.backgroundColor = ThemeApp.cardBackgroundColor, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: const TextStyle(
              color: ThemeApp.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: ThemeApp.secondaryTextColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}
