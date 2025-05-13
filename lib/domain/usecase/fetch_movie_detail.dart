import 'package:flutter_movie_app/domain/entity/movie_detail.dart';

import '../../data/repository/movie_repository.dart';

class FetchMovieDetail {
  final MovieRepository repository;

  FetchMovieDetail(this.repository);

  Future<MovieDetail?> execute(int id) async {
    return await repository.fetchMovieDetail(id);
  }
}