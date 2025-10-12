import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF23232A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a reply...',
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
