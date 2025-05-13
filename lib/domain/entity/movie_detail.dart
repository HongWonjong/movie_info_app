import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int budget;
  final List<String> genres;
  final int id;
  final List<String> productionCompanyLogos;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetail({
    required this.budget,
    required this.genres,
    required this.id,
    required this.productionCompanyLogos,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    budget,
    genres,
    id,
    productionCompanyLogos,
    overview,
    popularity,
    posterPath,
    releaseDate,
    revenue,
    runtime,
    tagline,
    title,
    voteAverage,
    voteCount,
  ];
}