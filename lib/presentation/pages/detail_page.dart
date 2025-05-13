import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/presentation/providers/detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common_app_bar.dart';

class DetailPage extends ConsumerStatefulWidget {
  final int movieId;
  final String heroTag;

  const DetailPage({super.key, required this.movieId, required this.heroTag});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  void initState() {
    super.initState();
    print('DetailPage initState - Hero tag: ${widget.heroTag}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Fetching movie detail for ID: ${widget.movieId}');
      ref.read(detailProvider.notifier).fetchMovieDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(detailProvider);

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Movie App',
        showBackButton: true, // 뒤로 가기 버튼 포함
      ),
      body: detailState.when(
        data: (state) {
          if (state.movieDetail == null) {
            print('Movie detail is null for ID: ${widget.movieId}');
            return const Center(child: Text('영화 정보를 불러올 수 없습니다.'));
          }
          print('Movie detail loaded: ${state.movieDetail!.title}');
          final movie = state.movieDetail!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.heroTag,
                  child: Image.network(
                    '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                    errorBuilder: (context, error, stackTrace) {
                      print('Image load error: $error');
                      return const Icon(Icons.error);
                    },
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
                            _buildInfoCard('예산', '\$${movie.budget}'),
                            _buildInfoCard('수익', '\$${movie.revenue}'),
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
                              errorBuilder: (context, error, stackTrace) {
                                print('Production logo load error: $error');
                                return const Icon(Icons.error);
                              },
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
        loading: () {
          print('Detail page loading for ID: ${widget.movieId}');
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          print('Detail page error for ID: ${widget.movieId}: $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('영화 정보를 불러오는 중 오류가 발생했습니다.'),
                Text('오류: $error'),
                ElevatedButton(
                  onPressed: () {
                    ref.read(detailProvider.notifier).fetchMovieDetail(widget.movieId);
                  },
                  child: const Text('재시도'),
                ),
              ],
            ),
          );
        },
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