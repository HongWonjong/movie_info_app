import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/presentation/providers/home_provider.dart';
import 'package:flutter_movie_app/presentation/widgets/movie_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movie App')),
      body: homeState.when(
        data: (state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '가장 인기있는',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Hero(
                    tag: 'popular_1',
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: state.popularMovies.isNotEmpty
                              ? NetworkImage('${ApiConstants.imageBaseUrl}${state.popularMovies[0].posterPath}')
                              : const NetworkImage('https://placehold.co/500x750'),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => const Icon(Icons.error),
                        ),
                      ),
                      child: state.popularMovies.isEmpty
                          ? const Center(child: Text('인기 영화 데이터를 불러올 수 없습니다.'))
                          : null,
                    ),
                  ),
                ),
                MovieList(title: '현재 상영중', fetchType: 'now_playing'),
                MovieList(title: '인기순', fetchType: 'popular', showRanking: true),
                MovieList(title: '평점 높은순', fetchType: 'top_rated'),
                MovieList(title: '개봉예정', fetchType: 'upcoming'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('데이터를 불러오는 중 오류가 발생했습니다.'),
              Text('오류: $error'),
              ElevatedButton(
                onPressed: () => ref.read(homeProvider.notifier).fetchAllMovies(),
                child: const Text('재시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}