class ApiEndpoints {
  ApiEndpoints._();

  // Base URL (TMDB for movie data)
  static const String baseUrl = 'https://api.themoviedb.org';

  /// TMDB API key (v3) — required for movie endpoints. Get at themoviedb.org/settings/api.
  static const String apiReadAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjc4NDI1OWY1NGI4MTJiMjE4MjkzZjdlMTljZmI1OCIsIm5iZiI6MTc3MDc1Nzc4MS41NjA5OTk5LCJzdWIiOiI2OThiOWU5NTM5ZTE5N2QwZjMxZTY2MjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.eK3t9F0o6HFHAk7jLWmzxIUHzrwAuWUX78y7wJD7asA';

  static const String apiKey = '1b784259f54b812b218293f7e19cfb58';

  /// Base URL for poster images (append poster_path from movie, e.g. /w500/path).
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  static const String nowPlaying = '/3/movie/now_playing';
  
  /// GET — Top rated movies. Query: api_key, language, page.
  static const String topRated = '/3/movie/top_rated';

  static const String popular = '/3/movie/popular';

    static String trending = '/3/trending/movie/day';

    static const String searchMovies = '/3/trending/movie/search';
  
  /// GET — Movie details by ID. Query: api_key, language.
  static String movieDetails(int movieId) => '/3/movie/$movieId';

  // ============== AUTHENTICATION ENDPOINTS ==============
  /// GET — Create new request token
  static const String requestToken = '/3/authentication/token/new';
  
  /// POST — Validate request token with login
  static const String validateWithLogin = '/3/authentication/token/validate_with_login';
  
  /// POST — Create new session
  static const String createSession = '/3/authentication/session/new';
  
  /// DELETE — Delete session
  static const String deleteSession = '/3/authentication/session';

  // ============== AUTH ENDPOINTS ==============
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String refreshToken = '/api/auth/refresh';
  
}