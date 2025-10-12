import 'package:flutter/material.dart';
import 'package:desafio_loomi/data/model/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onShare;
  final VoidCallback? onWatch;

  const MovieCard({
    super.key,
    required this.movie,
    this.onShare,
    this.onWatch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: DecorationImage(
          image: NetworkImage(movie.posterUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.genre,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.comment, color: Colors.white70, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'Comments ${movie.commentsCount}',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onWatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Color(0xFFAA73F0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Watch',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available until ${movie.availableUntil}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white70),
                        onPressed: onShare,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
