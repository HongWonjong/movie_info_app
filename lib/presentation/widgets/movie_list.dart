import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/presentation/providers/home_provider.dart';
import 'package:flutter_movie_app/presentation/widgets/movie_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieList extends ConsumerWidget {
  final String title;
  final String fetchType;
  final bool showRanking;

  const MovieList({
    super.key,
    required this.title,
    required this.fetchType,
    this.showRanking = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return homeState.when(
      data: (state) {
        List<Movie> movies = [];
        switch (fetchType) {
          case 'now_playing':
            movies = state.nowPlayingMovies;
            break;
          case 'popular':
            movies = state.popularMovies;
            break;
          case 'top_rated':
            movies = state.topRatedMovies;
            break;
          case 'upcoming':
            movies = state.upcomingMovies;
            break;
        }
        // 최대 20개로 제한
        movies = movies.length > 20 ? movies.sublist(0, 20) : movies;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 180, // 리스트뷰 높이 180
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MovieCard(
                      movie: movie,
                      heroTag: '${fetchType}_${movie.id}',
                      rank: showRanking ? index + 1 : null,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('오류 발생: $error')),
    );
  }
}