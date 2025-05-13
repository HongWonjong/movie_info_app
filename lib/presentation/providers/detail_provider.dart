import 'package:flutter_movie_app/presentation/providers/usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_app/domain/entity/movie_detail.dart';
import 'package:flutter_movie_app/domain/usecase/fetch_movie_detail.dart';

class DetailState {
  final MovieDetail? movieDetail;
  final bool isLoading;

  DetailState({
    this.movieDetail,
    this.isLoading = false,
  });

  DetailState copyWith({
    MovieDetail? movieDetail,
    bool? isLoading,
  }) {
    return DetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DetailNotifier extends AsyncNotifier<DetailState> {
  @override
  Future<DetailState> build() async {
    return DetailState();
  }

  Future<void> fetchMovieDetail(int id) async {
    print('Starting fetchMovieDetail for ID: $id');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final movieDetail = await ref.read(fetchMovieDetailProvider).execute(
        id,
        appendToResponse: 'videos,credits',
      );
      if (movieDetail == null) {
        print('fetchMovieDetail returned null for ID: $id');
      } else {
        print('fetchMovieDetail succeeded for ID: $id, title: ${movieDetail.title}');
      }
      return DetailState(movieDetail: movieDetail, isLoading: false);
    });
    print('fetchMovieDetail state updated for ID: $id, state: $state');
  }
}

final detailProvider = AsyncNotifierProvider<DetailNotifier, DetailState>(() => DetailNotifier());