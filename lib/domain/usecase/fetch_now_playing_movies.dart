import 'package:flutter_movie_app/domain/entity/movie.dart';
import '../../data/repository/movie_repository.dart';

class FetchNowPlayingMovies {
  final MovieRepository repository;

  FetchNowPlayingMovies(this.repository);

  Future<List<Movie>?> execute() async {
    return await repository.fetchNowPlayingMovies();
  }
}