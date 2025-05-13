import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/presentation/providers/home_provider.dart';
import 'package:flutter_movie_app/presentation/widgets/movie_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movie App')),
      body: homeState.when(
        data: (state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '가장 인기있는',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Hero(
                  tag: 'popular_1',
                  child: Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          state.popularMovies.isNotEmpty
                              ? '${ApiConstants.imageBaseUrl}${state.popularMovies[0].posterPath}'
                              : 'https://image.tmdb.org/t/p/w500/sample.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                MovieList(title: '현재 상영중', fetchType: 'now_playing'),
                MovieList(title: '인기순', fetchType: 'popular', showRanking: true),
                MovieList(title: '평점 높은순', fetchType: 'top_rated'),
                MovieList(title: '개봉예정', fetchType: 'upcoming'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류 발생: $error')),
      ),
    );
  }
}