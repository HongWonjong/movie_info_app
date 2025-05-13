import 'package:http/http.dart' as http;

class HttpClient {
  static final http.Client _client = http.Client();

  static http.Client get client => _client;
}