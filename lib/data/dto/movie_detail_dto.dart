import 'package:equatable/equatable.dart';

class MovieDetailDto extends Equatable {
  final int budget;
  final List<GenreDto> genres;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanyDto> productionCompanies;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetailDto({
    required this.budget,
    required this.genres,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailDto(
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List)
          .map((e) => GenreDto.fromJson(e))
          .toList(),
      id: json['id'],
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies: (json['production_companies'] as List)
          .map((e) => ProductionCompanyDto.fromJson(e))
          .toList(),
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    budget,
    genres,
    id,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    releaseDate,
    revenue,
    runtime,
    tagline,
    title,
    voteAverage,
    voteCount,
  ];
}

class GenreDto extends Equatable {
  final int id;
  final String name;

  GenreDto({required this.id, required this.name});

  factory GenreDto.fromJson(Map<String, dynamic> json) {
    return GenreDto(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class ProductionCompanyDto extends Equatable {
  final int id;
  final String logoPath;
  final String name;

  ProductionCompanyDto({
    required this.id,
    required this.logoPath,
    required this.name,
  });

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyDto(
      id: json['id'],
      logoPath: json['logo_path'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name];
}