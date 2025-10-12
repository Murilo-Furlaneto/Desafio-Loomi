import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 24),
          IconButton(
            icon: const Icon(Icons.pause_circle, color: Colors.white, size: 40),
            onPressed: () {},
          ),
          const SizedBox(width: 24),
          IconButton(
            icon: const Icon(Icons.forward_10, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
