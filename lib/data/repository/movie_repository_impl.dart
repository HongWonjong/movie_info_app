import 'package:flutter_movie_app/data/datasource/movie_datasource.dart';
import 'package:flutter_movie_app/data/dto/movie_response_dto.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/domain/entity/movie_detail.dart';

import 'movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final response = await dataSource.fetchNowPlayingMovies();
    return _mapToMovies(response);
  }

  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final response = await dataSource.fetchPopularMovies();
    return _mapToMovies(response);
  }

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final response = await dataSource.fetchTopRatedMovies();
    return _mapToMovies(response);
  }

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final response = await dataSource.fetchUpcomingMovies();
    return _mapToMovies(response);
  }

  @override
  Future<MovieDetail?> fetchMovieDetail(int id, {String appendToResponse = ''}) async {
    final response = await dataSource.fetchMovieDetail(id, appendToResponse: appendToResponse);
    if (response == null) return null;
    return MovieDetail(
      budget: response.budget,
      genres: response.genres.map((e) => e.name).toList(),
      id: response.id,
      productionCompanyLogos:
      response.productionCompanies.map((e) => e.logoPath).toList(),
      overview: response.overview,
      popularity: response.popularity,
      posterPath: response.posterPath,
      releaseDate: DateTime.parse(response.releaseDate),
      revenue: response.revenue,
      runtime: response.runtime,
      tagline: response.tagline,
      title: response.title,
      voteAverage: response.voteAverage,
      voteCount: response.voteCount,
    );
  }

  List<Movie>? _mapToMovies(MovieResponseDto? response) {
    if (response == null) return null;
    return response.results
        .map((dto) => Movie(id: dto.id, posterPath: dto.posterPath))
        .toList();
  }
}