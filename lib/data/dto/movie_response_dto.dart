import 'package:equatable/equatable.dart';

class MovieResponseDto extends Equatable {
  final List<MovieDto> results;

  MovieResponseDto({required this.results});

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      results: (json['results'] as List)
          .map((e) => MovieDto.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results];
}

class MovieDto extends Equatable {
  final int id;
  final String posterPath;

  MovieDto({required this.id, required this.posterPath});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'],
      posterPath: json['poster_path'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, posterPath];
}