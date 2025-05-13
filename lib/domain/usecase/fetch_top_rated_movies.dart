import 'package:flutter_movie_app/domain/entity/movie.dart';
import '../../data/repository/movie_repository.dart';

class FetchTopRatedMovies {
  final MovieRepository repository;

  FetchTopRatedMovies(this.repository);

  Future<List<Movie>?> execute() async {
    return await repository.fetchTopRatedMovies();
  }
}