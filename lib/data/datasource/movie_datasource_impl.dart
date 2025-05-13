import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movie_app/core/constants/api_constants.dart';
import 'package:flutter_movie_app/data/dto/movie_response_dto.dart';
import 'package:flutter_movie_app/data/dto/movie_detail_dto.dart';
import 'movie_datasource.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final http.Client client;

  MovieDataSourceImpl(this.client);

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() async {
    return _fetchMovies(ApiConstants.nowPlaying);
  }

  @override
  Future<MovieResponseDto?> fetchPopularMovies() async {
    return _fetchMovies(ApiConstants.popular);
  }

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() async {
    return _fetchMovies(ApiConstants.topRated);
  }

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() async {
    return _fetchMovies(ApiConstants.upcoming);
  }

  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) async {
    final response = await _makeRequest(ApiConstants.movieDetail(id));
    if (response.statusCode == 200) {
      return MovieDetailDto.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<MovieResponseDto?> _fetchMovies(String url) async {
    final response = await _makeRequest(url);
    if (response.statusCode == 200) {
      return MovieResponseDto.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<http.Response> _makeRequest(String url) async {
    final headers = {
      'Authorization': 'Bearer ${dotenv.env['TMDB_API_KEY']}',
      'Accept': 'application/json',
    };
    return await client.get(Uri.parse('$url?language=ko-KR&page=1'), headers: headers);
  }
}