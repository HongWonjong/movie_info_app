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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final movieDetail = await ref.read(fetchMovieDetailProvider).execute(id);
      return DetailState(movieDetail: movieDetail, isLoading: false);
    });
  }
}

final detailProvider = AsyncNotifierProvider<DetailNotifier, DetailState>(() => DetailNotifier());