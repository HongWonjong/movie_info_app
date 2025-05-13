class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String nowPlaying = '$baseUrl/movie/now_playing';
  static const String popular = '$baseUrl/movie/popular';
  static const String topRated = '$baseUrl/movie/top_rated';
  static const String upcoming = '$baseUrl/movie/upcoming';
  static String movieDetail(int id) => '$baseUrl/movie/$id';
}