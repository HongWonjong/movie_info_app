import 'package:flutter_movie_app/presentation/providers/usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_now_playing_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_popular_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_top_rated_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_upcoming_movies.dart';

class HomeState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final bool isLoading;

  HomeState({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    bool? isLoading,
  }) {
    return HomeState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    return HomeState();
  }

  Future<void> fetchAllMovies() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final nowPlaying = await ref.read(fetchNowPlayingMoviesProvider).execute();
      final popular = await ref.read(fetchPopularMoviesProvider).execute();
      final topRated = await ref.read(fetchTopRatedMoviesProvider).execute();
      final upcoming = await ref.read(fetchUpcomingMoviesProvider).execute();


      return HomeState(
        nowPlayingMovies: nowPlaying ?? [],
        popularMovies: popular ?? [],
        topRatedMovies: topRated ?? [],
        upcomingMovies: upcoming ?? [],
        isLoading: false,
      );
    });
  }
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(() => HomeNotifier());