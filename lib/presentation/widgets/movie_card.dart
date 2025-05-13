import 'package:flutter/material.dart';
import '../../core/constants/api_constants.dart';
import '../../domain/entity/movie.dart';
import '../pages/detail_page.dart';


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
    return GestureDetector(
      onTap: () {
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                  ),
                  fit: BoxFit.cover,
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
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}