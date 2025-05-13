import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/presentation/providers/detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final int movieId;
  final String heroTag;

  const DetailPage({super.key, required this.movieId, required this.heroTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(detailProvider.notifier).fetchMovieDetail(movieId);
    final detailState = ref.watch(detailProvider);

    return Scaffold(
      body: detailState.when(
        data: (state) {
          if (state.movieDetail == null) {
            return const Center(child: Text('영화 정보를 불러올 수 없습니다.'));
          }
          final movie = state.movieDetail!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: heroTag,
                  child: Image.network(
                    '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('개봉일: ${movie.releaseDate.toString().substring(0, 10)}'),
                      const SizedBox(height: 8),
                      Text('태그라인: ${movie.tagline}'),
                      const SizedBox(height: 8),
                      Text('러닝타임: ${movie.runtime}분'),
                      const SizedBox(height: 8),
                      Text('카테고리: ${movie.genres.join(', ')}'),
                      const SizedBox(height: 16),
                      const Text(
                        '영화 설명',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(movie.overview),
                      const SizedBox(height: 16),
                      const Text(
                        '흥행 정보',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildInfoCard('평점', '${movie.voteAverage}'),
                            _buildInfoCard('투표수', '${movie.voteCount}'),
                            _buildInfoCard('인기점수', '${movie.popularity}'),
                            _buildInfoCard('예산', '${movie.budget}'),
                            _buildInfoCard('수익', '${movie.revenue}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '제작사',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: movie.productionCompanyLogos
                              .map((logo) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              '${ApiConstants.imageBaseUrl}$logo',
                              fit: BoxFit.contain,
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류 발생: $error')),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}