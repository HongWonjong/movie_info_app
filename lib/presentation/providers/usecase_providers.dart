import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_app/data/datasource/movie_datasource.dart';
import 'package:flutter_movie_app/data/datasource/movie_datasource_impl.dart';
import 'package:flutter_movie_app/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_now_playing_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_popular_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_top_rated_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_upcoming_movies.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_movie_detail.dart';
import 'package:flutter_movie_app/core/network/http_client.dart';

import '../../data/repository/movie_repository.dart';

// DataSource Provider
final movieDataSourceProvider = Provider<MovieDataSource>((ref) {
  return MovieDataSourceImpl(HttpClient.client);
});

// Repository Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dataSource = ref.watch(movieDataSourceProvider);
  return MovieRepositoryImpl(dataSource);
});

// UseCase Providers
final fetchNowPlayingMoviesProvider = Provider<FetchNowPlayingMovies>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchNowPlayingMovies(repository);
});

final fetchPopularMoviesProvider = Provider<FetchPopularMovies>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchPopularMovies(repository);
});

final fetchTopRatedMoviesProvider = Provider<FetchTopRatedMovies>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchTopRatedMovies(repository);
});

final fetchUpcomingMoviesProvider = Provider<FetchUpcomingMovies>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchUpcomingMovies(repository);
});

final fetchMovieDetailProvider = Provider<FetchMovieDetail>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchMovieDetail(repository);
});