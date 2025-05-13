import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String posterPath;

  Movie({
    required this.id,
    required this.posterPath,
  });

  @override
  List<Object?> get props => [id, posterPath];
}