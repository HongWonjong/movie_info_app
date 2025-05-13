class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String nowPlaying = '$baseUrl/movie/now_playing';
  static const String popular = '$baseUrl/movie/popular';
  static const String topRated = '$baseUrl/movie/top_rated';
  static const String upcoming = '$baseUrl/movie/upcoming';
  static String movieDetail(int id, {String append = ''}) {
    final base = '$baseUrl/movie/$id';
    return append.isEmpty ? base : '$base?append_to_response=$append';
  }

  // 주요 장르 ID (TMDB 공식 문서 참조)
  static const Map<String, int> genreIds = {
    '액션': 28,
    '모험': 12,
    '애니메이션': 16,
    '코미디': 35,
    '드라마': 18,
    '판타지': 14,
    '공포': 27,
    '로맨스': 10749,
    'SF': 878,
    '스릴러': 53,
  };
}