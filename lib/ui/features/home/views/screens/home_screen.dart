import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:desafio_loomi/ui/features/home/store/home_store.dart';
import 'package:desafio_loomi/ui/features/home/views/widgets/movie_card.dart';
import 'package:desafio_loomi/ui/features/player/views/screens/player_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:desafio_loomi/di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore _homeStore = getIt<HomeStore>();

  @override
  void initState() {
    super.initState();
    _homeStore.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18181C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 20,
          child: Image.asset("assets/images/logo.png"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: IconButton( color: Colors.white, onPressed: () { 
                Navigator.pushNamed(context, '/profile');
               }, icon: Icon(Icons.person,),),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_homeStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_homeStore.errorMessage != null) {
            return Center(
              child: Text(
                _homeStore.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (_homeStore.movies.isEmpty) {
            return const Center(
              child: Text(
                'No movies found',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            itemCount: _homeStore.movies.length,
            itemBuilder: (context, index) {
              final movie = _homeStore.movies[index];
              return MovieCard(
                movie: movie,
                onShare: () {
                  Share.share('Check out this movie: ${movie.title}');
                },
                onWatch: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlayerScreen(movie: movie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
