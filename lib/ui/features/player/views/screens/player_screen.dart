import 'package:flutter/material.dart';
import 'package:desafio_loomi/data/model/movie_model.dart';
import 'package:desafio_loomi/ui/features/player/views/widgets/player_controls.dart';
import 'package:desafio_loomi/ui/features/player/views/widgets/comment_card.dart';
import 'package:desafio_loomi/ui/features/player/views/widgets/comment_input.dart';

class PlayerScreen extends StatelessWidget {
  final MovieModel movie;
  const PlayerScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18181C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(movie.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.play_circle, color: Colors.white, size: 64),
              ),
            ),
          ),
          const PlayerControls(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${movie.commentsCount} Comments',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Close', style: TextStyle(color: Colors.purple)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      CommentCard(),
                      CommentCard(),
                    ],
                  ),
                ),
                const CommentInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
