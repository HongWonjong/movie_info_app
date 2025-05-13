import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/domain/entity/movie.dart';
import 'package:flutter_movie_app/presentation/pages/detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final String heroTag;
  final int? rank;

  const MovieCard({
    super.key,
    required this.movie,
    required this.heroTag,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    print('MovieCard build - Hero tag: $heroTag');
    return GestureDetector(
      onTap: () {
        print('Navigating to DetailPage with heroTag: $heroTag');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              movieId: movie.id,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    movie.posterPath.isNotEmpty
                        ? '${ApiConstants.imageBaseUrl}${movie.posterPath}'
                        : 'https://placehold.co/120x180',
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('MovieCard image load error: $exception');
                  },
                ),
              ),
            ),
          ),
          if (rank != null)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.black54,
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}