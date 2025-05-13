import 'package:flutter_movie_app/domain/entity/movie.dart';

import '../../data/repository/movie_repository.dart';

class FetchUpcomingMovies {
  final MovieRepository repository;

  FetchUpcomingMovies(this.repository);

  Future<List<Movie>?> execute() async {
    return await repository.fetchUpcomingMovies();
  }
}