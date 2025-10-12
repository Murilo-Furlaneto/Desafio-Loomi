import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF23232A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Eva Mendes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('2 weeks ago', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mollis gravida faucibus sollicitudin ut tincidunt.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('View 12 replies', style: TextStyle(color: Colors.purple, fontSize: 13)),
                    ),
                    const SizedBox(width: 8),
                    Text('REPLY', style: TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white54),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
